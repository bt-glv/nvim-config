
function Parse_termc(key) return vim.api.nvim_replace_termcodes(key, true, false, true) end
local tab = Parse_termc("<Tab>")
local esc = Parse_termc("<Esc>")
local cr = Parse_termc("<Cr>")
local cc = Parse_termc("<c-c>")
local up = Parse_termc("<Up>")


-- simple log functions for debugging
local _log = "\n"
function _logit(input)
	_log = _log..input..'\n' end
function _logprint()
	Notify(_log) end

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

function Pwc() -- WIP
	local current_file_path = vim.fn.expand('%:p')
	-- check if the current file has a path
	-- current_file_path = vim.fn.substitute(current_file_path, "^oil:[/][/]","","g")
	vim.fn.setreg('+', current_file_path)
	print("> File Path Copied to the Clipboard")
end

