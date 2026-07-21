return {
	'neovim/nvim-lspconfig',
	lazy = false,
	dependencies = {},
	opts = {},
	config = function()
		Lsp_settings:setup()
		Lsp_settings:local_lsp_init()
	end
}
