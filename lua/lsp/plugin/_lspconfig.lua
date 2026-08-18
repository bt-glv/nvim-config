return {
	'neovim/nvim-lspconfig',
	lazy = false,
	dependencies = {},
	opts = {},
	config = function()
		Lsp_tools:setup()
		Lsp_tools:local_lsp_init()
	end
}
