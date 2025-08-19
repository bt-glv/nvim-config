

function Parse_termc(key) return vim.api.nvim_replace_termcodes(key, true, false, true) end
local tab = Parse_termc("<Tab>")
local esc = Parse_termc("<Esc>")
local cr = Parse_termc("<Cr>")
local cc = Parse_termc("<c-c>")
local up = Parse_termc("<Up>")


-- The command line buffer does not have a name.
-- This is the best way I found to check if the buffer is the command line buffer
local function is_commandline_buf()

	local bufname =	(function()
		local bufname = vim.api.nvim_buf_get_name(0)
		return (bufname == ""
		or bufname == nil
		or vim.fn.match(bufname, '[[]Command Line[]]$') ~= -1)
	end)()

	local undo_ftplugin	= (function()
		local success, undo_plug_var = pcall(function() return vim.api.nvim_buf_get_var(0, "undo_ftplugin") end)
		if not success then return false end
		return undo_plug_var == "call VimFtpluginUndo()"
	end)()

	local filetype = (vim.bo[0].filetype == "vim")

	return (filetype and bufname and undo_ftplugin)

end

function ClearTerm(reset)
	vim.opt_local.scrollback = 1

	vim.api.nvim_command("startinsert")
	if reset == 1 then
		vim.api.nvim_feedkeys("reset", 't', false)
	else
		vim.api.nvim_feedkeys("clear", 't', false)
	end
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<cr>', true, false, true), 't', true)

	-- defines maximum amount of lines
	-- neovim's terminal mode will store in its buffer
	vim.opt_local.scrollback = 10000
end

Exit_to_file_path = function() vim.cmd('qa!') end

-- still not completely sure of why i created this
local cmdline_toggle = false
function Cmdline_buff_control()
	local is_commandline 	= is_commandline_buf()
	local mode 				= vim.api.nvim_get_mode().mode

	if mode == "n" and not is_commandline then
		vim.api.nvim_feedkeys(":"..up,"t",false)
		cmdline_toggle = false
		return
	end
	if mode == "c" and not is_commandline then
		if cmdline_toggle then
			vim.api.nvim_feedkeys(esc,"t",false)
			cmdline_toggle = false
			return
		end
		vim.api.nvim_feedkeys(esc.."q:k","t",false)
		return
	end
	if mode == "n" and is_commandline then
		vim.api.nvim_feedkeys(cc..cc..":"..up,"t",false)
		cmdline_toggle = true
		return
	end
	if mode == "i" and is_commandline then
		vim.api.nvim_feedkeys(cc..cc,"t",false)
		return
	end
end

function Manual_surround()

	local function invert_simple(input_end)
		input_end = string.gsub(input_end,'%[',']')
		input_end = string.gsub(input_end,'%(',')')
		input_end = string.gsub(input_end,'%{','}')
		return input_end
	end
	-- TODO: Add tag detection with vim regex and handle it

	local function invert_vimscript()
		-- TODO: remake invert_simple using vim regex
	end

	local input 		= vim.fn.input('>')
	local input_end 	= invert_simple(input)
	local expression 	= esc.."`>a"..input_end..esc.."`<i"..input..esc.."lm<".."`>"..#input.."lm>"

	vim.api.nvim_feedkeys(expression, "xn", false)
end


-- # Block indent
--
-- [ ] 	check if the search match is after the pivot
-- 		if so, de-indent it untill it reaches the pivot
--
-- [ ] 	also check if the match is on the pivot and solve that also
--
-- [ ]  find a way to add more caracters to the end of all selected lines
-- 		to make it easier to select on block selection mode

---@param tabstop integer | nil Amount of spaces a 'tab' character occupies
function Block_indent(tabstop)

	-- if vim.o.expandtab then vim.o.expandtab = false end

	-- only executes the function if visual block mode is the active mode
	if vim.api.nvim_get_mode().mode ~= "\22" then return end

	-- if tabstop isnt defined
	tabstop = tabstop or vim.o.tabstop


	local function first_tab(column, tabstop)
		local tab_size = tabstop-(column%tabstop)
		local tab_string = (
			function()
				local out = ""
				for i=1, tab_size do
					out = out.." "
				end
				return out
			end
		)()
		return {size = tab_size, string = tab_string}
	end

	local function calc_tabs_amount(col_cursor, col_pivot, tabstop)

		local f_size, _ = first_tab(col_cursor, tabstop).size
		local loop_position = col_cursor
		local amount = 0

		loop_position = loop_position + f_size
		amount = amount + 1
		if loop_position >= col_pivot then return amount end

		while true do
			loop_position=loop_position+tabstop
			amount=amount+1
			if loop_position >= col_pivot then return amount end
		end
	end

	local function reach_back(input) -- TODO: improve this
		if #input == 1 then input = "["..input.."]" end
		vim.api.nvim_feedkeys(esc..[[:silent g/\v%.l((]]..input..[[)|(^))/]]..cr.."N","xn", false)
		-- vim.cmd("noh")
	end

	local function create_col_table()

		local out_positions= {}
		local search = vim.fn.searchcount().total
		local position

		for i = 1, search do
			position = {
				line = vim.api.nvim_win_get_cursor(0)[1],
				column = vim.api.nvim_win_get_cursor(0)[2],
			}
			table.insert( out_positions, position )
			vim.api.nvim_feedkeys(esc.."n","xn", false)
		end
		return out_positions
	end
	local function tabs_till_pivot(cursor_pos, pivot_pos, tabstop)

		local function f_tab(column, tabstop)
			local _mod = column%tabstop
			if _mod == 0 then return tabstop end
			return tabstop-_mod
		end

		if cursor_pos >= pivot_pos then return 0 end

		local first = f_tab(cursor_pos, tabstop)
		local current_pos = cursor_pos + first
		local counter_tab = 1

		if current_pos > pivot_pos then return counter_tab end

		counter_tab = 1
		while current_pos <= pivot_pos do
			current_pos = current_pos + tabstop
			counter_tab = counter_tab + 1
		end

		return counter_tab
	end

	vim.api.nvim_feedkeys(esc..[[:silent '<,'>g/\%V.\+/]]..cr..cr.."n","xn",false)
	local col_table = create_col_table()
	local input = vim.fn.input('>')

	-- local _log = "\n"
	-- local function logit(input)
		-- _log = _log..input..'\n'
	-- end

	local _tab = Parse_termc("<Tab>")

	for _, positions in pairs(col_table) do
		vim.api.nvim_win_set_cursor(0,{positions.line, positions.column}) -- move the cursor the the pivot_col
		reach_back(input) -- move the cursor to the key character

		local cursor_col = vim.api.nvim_win_get_cursor(0)[2]
		local pivot_col = positions.column

		local tabs_amount = tabs_till_pivot(cursor_col, pivot_col, tabstop)
		local tabs = ""
		for i=1, tabs_amount do
			tabs=tabs.._tab
		end
		-- logit(cursor_col..' -> '..pivot_col)
		-- logit(tabs_amount)
		-- logit('.'..tabs..'.')


		vim.api.nvim_feedkeys("i"..tabs..esc, "xn", false)
	end

	-- Notify(_log)
	vim.cmd("noh")
end




