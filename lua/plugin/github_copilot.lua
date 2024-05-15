
local outside_usage = true
function Copilot_enable() 	if outside_usage then cmd("Copilot enable") end 	end
function Copilot_disable() 	if outside_usage then cmd("Copilot disable") end 	end
function Copilot_setup()	if outside_usage then cmd("Copilot setup") end		end

local function main()
	-- kmn("<leader>ce", ":Copilot enable<cr>")
	-- kmn("<leader>cd", ":Copilot disable<cr>")
	kmn("<leader>cs", ":Copilot setup<cr>")
	kmn("<leader>ce", ":let b:copilot_enabled = 1")
	kmn("<leader>cd", ":let b:copilot_enabled = 0")
	cmd("au BufNewFile,BufRead * let b:copilot_enabled = 0")
	-- Autocmd that disables copilot on every buffer 
	-- In this config file, the opposite can also be done: setting b:copilot_enabled=0 in buffer_settings and using b:copilot_enabled=1 to enable it via a shortcut.
	-- Source: https://github.com/orgs/community/discussions/57887#discussioncomment-7768432
end


local function error_handler(err)
	if not Show_full_errors then err = "" end
	print("\n\n<<  ERROR  >>\n Github Copilot -> error processing main function/config\nMaybe its not installed?\n\n" .. err) end

-- Exec
plugin_add([[
Plug 'github/copilot.vim'
]])

plugin_add_config(function() xpcall(main, error_handler) end)
