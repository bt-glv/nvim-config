
return {
    'nvim-treesitter/nvim-treesitter',
    run          = ":TSUpdate",
    lazy         = false,
    dependencies = {},
    priority     = 100,

	main = "nvim-treesitter.configs",
	opts = {
		ensure_installed = {
			'lua',
			'vim',
			'vimdoc',

			'javascript',
			'html',
			'css',
			'typescript',

			'markdown_inline',
			'markdown',
			'latex',

			'java',
			'python',
			'go',
			'c',
			'bash',
			'diff',
			'query',

			'json',
			'xml',
			'yaml'
		},
		highlight = {
			enable                            = true,
			additional_vim_regex_highlighting = false,
		},
		sync_install   = false,
		auto_install   = true,
		ignore_install = {},
	},
}
