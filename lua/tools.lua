
-- simple log functions for debugging
local _log = "\n"
function Logit(input) _log = _log..input..'\n' end
function Logprint() Notify(_log) end
function Parse_termc(key) return vim.api.nvim_replace_termcodes(key, true, false, true) end

local tab = Parse_termc("<Tab>")
local esc = Parse_termc("<Esc>")
local cr  = Parse_termc("<Cr>")
local cc  = Parse_termc("<c-c>")
local up  = Parse_termc("<Up>")


---@param string string Notification Body
---@param priority number Priority 1 - 6; 4:error, 6:bug
---@param opts {title: string} Aditional parameters, such as Title
Notify = function(string, priority, opts) vim.notify(string) end

--- The command line buffer does not have a name.
--- This is the best way I found to check if the buffer is the command line buffer
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


return {

	Global = {

		pwc_relative = function()
			local current_file_path = vim.fn.expand('%:p')
			local cwd = vim.fn.getcwd()
			current_file_path = vim.fn.substitute(current_file_path, "^"..cwd,"","g")

			vim.fn.setreg('+', current_file_path)
			print("> <<Relative>> File Path Copied to the Clipboard")
		end,

		pwc = function()
			local current_file_path = vim.fn.expand('%:p')
			vim.fn.setreg('+', current_file_path)
			print("> File Path Copied to the Clipboard")
		end,

		leader_colon = function()
			local is_commandline 	= is_commandline_buf()
			local mode 				= vim.api.nvim_get_mode().mode

			if(not is_commandline) then
				if(mode == "n") then
					vim.api.nvim_feedkeys("q:i","t",false)
					return
				end
				return
			end

			if (mode == "i" or mode == "n") then
				vim.api.nvim_feedkeys(cc..cc,"t",false)
				return
			end

		end,

		cmdline_toggle = false,
		cmd_line_conditional_toggle = function(self)
			local is_commandline 	= is_commandline_buf()
			local mode 				= vim.api.nvim_get_mode().mode

			if mode == "n" and not is_commandline then
				vim.api.nvim_feedkeys(":"..up,"t",false)
				self.cmdline_toggle = false
				return
			end
			if mode == "c" and not is_commandline then
				if self.cmdline_toggle then
					vim.api.nvim_feedkeys(esc,"t",false)
					self.cmdline_toggle = false
					return
				end
				vim.api.nvim_feedkeys(esc.."q:k","t",false)
				return
			end
			if mode == "n" and is_commandline then
				vim.api.nvim_feedkeys(cc..cc..":"..up,"t",false)
				self.cmdline_toggle = true
				return
			end
			if mode == "i" and is_commandline then
				vim.api.nvim_feedkeys(cc..cc,"t",false)
				return
			end
		end,

		exit_to_file_path = function()
			vim.cmd('qa!')
		end,

		clear_term = function(reset)
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
		end,
	},

	Linux = {

		--- This function block the main UI thread.
		--- This shouln't be a problem since "file" and "gio" run within a few miliseconds.
		get_apps = function(file)
			local apps = {
				{ name = "System Default (xdg-open)", cmd = { "xdg-open", file } },
			}

			-- Get MIME type of the file
			local mime_handle = io.popen(string.format("file --mime-type -b '%s' 2>/dev/null", file))
			local mime        = mime_handle and mime_handle:read("*l")

			if mime_handle then mime_handle:close() end

			if not mime or mime == "" then return apps end

			-- Query registered desktop applications for this MIME type
			local gio_handle = io.popen(string.format("gio mime '%s' 2>/dev/null", mime))

			if gio_handle then
				local default_app = nil
				for line in gio_handle:lines() do
					-- Parse default application
					local def = line:match("Default application for .+: (.+%.desktop)")
					if def then
						default_app = def
						table.insert(apps, {
							name = "[Default] " .. def:gsub("%.desktop$", ""),
							desktop = def,
						})
					end

					-- Parse registered & recommended alternatives
					local desktop_file = line:match("^%s+([%w%-%._]+%.desktop)")
					if desktop_file and desktop_file ~= default_app then
						table.insert(apps, {
							name = desktop_file:gsub("%.desktop$", ""),
							desktop = desktop_file,
						})
					end
				end
				gio_handle:close()
			end

			return apps
		end
	}


}
