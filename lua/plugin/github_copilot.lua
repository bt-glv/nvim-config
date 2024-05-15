
local outside_usage = true
function Copilot_enable() 	if outside_usage then cmd("Copilot enable") end 	end
function Copilot_disable() 	if outside_usage then cmd("Copilot disable") end 	end
function Copilot_setup()	if outside_usage then cmd("Copilot setup") end		end

local function main()
	Copilot_disable()
	kmn("<leader>cs", ":Copilot setup<cr>")
	kmn("<leader>ce", ":Copilot enable<cr>")
	kmn("<leader>cd", ":Copilot disable<cr>")
end


local function error_handler(err)
	if not Show_full_errors then err = "" end
	print("\n\n<<  ERROR  >>\n Github Copilot -> error processing main function/config\nMaybe its not installed?\n\n" .. err) end

-- Exec
plugin_add([[
Plug 'github/copilot.vim'
]])

plugin_add_config(function() xpcall(main, error_handler) end)
