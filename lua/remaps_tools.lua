

function Parse_termc(key) return vim.api.nvim_replace_termcodes(key, true, false, true) end
local tab = Parse_termc("<Tab>")
local esc = Parse_termc("<Esc>")
local cr = Parse_termc("<Cr>")
local cc = Parse_termc("<c-c>")
local up = Parse_termc("<Up>")

function Execute_if_command_line_buff(if_exec,else_exec,mode)
	local bufnr 			= vim.api.nvim_get_current_buf()
	local filetype 			= vim.bo[bufnr].filetype
	local bufname			= vim.api.nvim_buf_get_name(bufnr)
	local undo_ftplugin		= (function()
		local suc, und = pcall(function() return vim.api.nvim_buf_get_var(bufnr, "undo_ftplugin") end)
		if not suc then return "" end; return und
	end)()

	if filetype == "vim" and (bufname == "" or bufname == nil) and undo_ftplugin == "call VimFtpluginUndo()" then
		vim.api.nvim_feedkeys(if_exec, mode, false)
		return
	end

	vim.api.nvim_feedkeys(else_exec, mode, false)
end



local function is_commandline_buf()
	local bufnr 			= vim.api.nvim_get_current_buf()
	local filetype 			= vim.bo[bufnr].filetype
	local bufname			= vim.api.nvim_buf_get_name(bufnr)
	local undo_ftplugin		= (function()
		local suc, und = pcall(function() return vim.api.nvim_buf_get_var(bufnr, "undo_ftplugin") end)
		if not suc then return "" end; return und
	end)()

	if filetype == "vim" and (bufname == "" or bufname == nil) and undo_ftplugin == "call VimFtpluginUndo()"
	then return true end
	return false
end


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
		-- #TODO: Add tag detection with vim regex and handle it

		local function invert_vimscript()
			-- #TODO: remake invert_simple using vim regex
		end

		local input 		= vim.fn.input('>')
		local input_end 	= invert_simple(input)
		local expression 	= esc.."`>a"..input_end..esc.."`<i"..input..esc.."lm<".."`>"..#input.."lm>"

		vim.api.nvim_feedkeys(expression, "xn", false)
end

function Block_indent()

	-- only executes the function if visual block mode is the active mode
	if vim.api.nvim_get_mode().mode ~= "\22" then return end

	-- Variables
	local positions = {}
	local indent_size = 4

	-- functions
	local function reach_back() vim.api.nvim_feedkeys("b","xn", false) end
	local function reach_back2(input)
		if #input == 1 then input = "["..input.."]" end
		-- vim.api.nvim_feedkeys(esc..[[:silent g/\%.l\(\(]]..input..[[\)\|\(^.\)/\)]].."|noh"..cr.."??e"..cr.."l","xn", false)
		-- vim.api.nvim_feedkeys(":noh"..cr,"xn", false)

		vim.api.nvim_feedkeys(esc..[[:silent g/\v%.l((]]..input..[[)|(^.))/]]..cr.."??e"..cr,"xn", false)
		-- silent g/\v%.l(([(])|(^.))/
		--
		vim.cmd("noh")
	end



	-- Code
	vim.api.nvim_feedkeys(esc..[[:silent '<,'>g/\%V.\+/]]..cr..cr.."n","xn",false)
	local search = vim.fn.searchcount().total

	positions = nil
	positions = {}
	for i = 1, search do
		local row = vim.api.nvim_win_get_cursor(0)[1]
		local col = vim.api.nvim_win_get_cursor(0)[2]
		table.insert(positions, {row, col})
		vim.api.nvim_feedkeys(esc.."n","xn", false)
	end

	local input = vim.fn.input('>')
	local coluna_cursor
	local coluna_alvo

	for _, cordinates in pairs(positions) do (function()

			vim.api.nvim_feedkeys(esc..cordinates[1].."gg0"..cordinates[2].."l", "xn", false)
			reach_back2(input)

			coluna_cursor 	= vim.api.nvim_win_get_cursor(0)[2]; if coluna_cursor >= cordinates[2] then return end
			coluna_alvo 	= cordinates[2]

			while coluna_cursor <= coluna_alvo do

				coluna_cursor = vim.api.nvim_win_get_cursor(0)[2]

				local mod = coluna_cursor%indent_size
				if mod == 0
					then coluna_alvo = coluna_alvo - 1
					else coluna_alvo = coluna_alvo - (5-mod)
				end

				vim.api.nvim_feedkeys(esc.."i"..tab..esc.."l", "xn", false)
				coluna_cursor = vim.api.nvim_win_get_cursor(0)[2]

				-- local coluna_cursor_mod = coluna_cursor%indent_size
				-- if coluna_cursor_mod == 0 then coluna_cursor_mod = indent_size end
				-- coluna_alvo = coluna_alvo - ((indent_size+1) - coluna_cursor_mod) + 1
			end


		end)() end -- for loop end

		vim.cmd("noh")
end


