
local function main()
	require'nvim-treesitter.configs'.setup {
	  ensure_installed = {"javascript","html","css","python", "go", "c", "lua", "vim", "vimdoc", "query","bash","json" },

	  sync_install = false,
	  auto_install = true,
	  highlight = {
	    enable = true,
	    additional_vim_regex_highlighting = false,
	  },
	}
end

local function error_handler(err)
	print("\n\n<<  ERROR  >>\nTreesitter Config -> error processing main function/config\nTreesitter may not be installed\n\n" .. err)
	return "Treesitter Config -> error processing main function/config"
end

-- Exec
plugin_add([[Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}]])
plugin_add_config(function() xpcall(main, error_handler) end)
