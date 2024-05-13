local function main()
	kmn( "<leader>pv", ":Neotree<cr>")
end

local function error_handler(err)
	if not Show_errors then err = "" end
	print("\n\n<<  ERROR  >>\nneo-tree -> error processing main function/config\nMaybe its not installed?\n\n" .. err) end

-- Exec
plugin_add([[
Plug 'nvim-neo-tree/neo-tree.nvim', {'branch': 'v3.x'}
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'
]])

plugin_add_config(function() xpcall(main, error_handler) end)
