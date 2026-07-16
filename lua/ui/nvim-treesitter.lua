
return {
    'nvim-treesitter/nvim-treesitter',
    run          = ":TSUpdate",
    lazy         = false,
    dependencies = {},
    priority     = 100,
	branch       = "main",
	main         = "nvim-treesitter",

	config = function()

		local required_parsers = {
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
		}
		require('nvim-treesitter').install(required_parsers)

	end

}
