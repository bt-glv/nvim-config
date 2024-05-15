
local function main()
end

local function error_handler(err)
	if not Show_full_errors then err = "" end
	print("\n\n<<  ERROR  >>\nSurround.vim -> error processing main function/config\nMaybe its not installed?\n\n" .. err) end

-- Exec
plugin_add([[
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
]])

plugin_add_config(function() xpcall(main, error_handler) end)
