
local config = {
	'nvim-treesitter/nvim-treesitter',
	run = ":TSUpdate",
	lazy = false,
	dependencies = {},
	priority = 100,
	config = function()
		require'nvim-treesitter.configs'.setup {
		  ensure_installed = {"javascript","html","css","python", "go", "c", "lua", "vim", "vimdoc", "query","bash","json" },

		  sync_install = false,
		  auto_install = true,
		  highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		  },
		}
	end -- END Config function 
}
Lazy_plugin_add(config)
