
local function main()
end

local function error_handler(err)
	if not Show_full_errors then err = "" end
	print("\n\n<<  ERROR  >>\n [plugin name] -> error processing main function/config\n\n" .. err) end

-- Exec
plugin_add([[
Plug 'sample/sample'
]])

plugin_add_config(function() xpcall(main, error_handler) end)
