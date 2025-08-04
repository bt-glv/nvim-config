
return {
    'nvim-treesitter/nvim-treesitter',
    run = ":TSUpdate",
    lazy = false,
    dependencies = {},
    priority = 100,
	opts = {
		ensure_installed = {
			'javascript',
			'html',
			'css',
			'python',
			'go',
			'c',
			'lua',
			'vim',
			'vimdoc',
			'query',
			'bash',
			'json',
			'diff',
			'markdown',
		},
		sync_install = false,
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		ignore_install = {},
	},
    config = function()
		-- this might be causing some weird treesitter parser errors
		-- involving parser initialization with 'diff' and 'golang'
		--vim.o.foldmethod = 'expr'
		--vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
		--vim.o.foldlevelstart = 99
	end,
}
