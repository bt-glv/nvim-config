return {
	'neovim/nvim-lspconfig',
	lazy = false,
	dependencies = {},
	opts = {},
	config = function()
		lsp_settings:setup()
		lsp_settings:local_lsp_init()
	end
}
