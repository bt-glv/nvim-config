
return {
	'williamboman/mason.nvim',
	lazy = false,
	dependencies = {
		'williamboman/mason-lspconfig.nvim',
		'neovim/nvim-lspconfig',
	},
	config = function()
		require('mason').setup({})
		require('mason-lspconfig').setup({
			automatic_enable = true,
			ensure_installed = lsp_settings.mason_lsp_servers,
			handlers = {
				function(server_name)
					-- require('lspconfig')[server_name].setup({})
					vim.lsp.enable(server_name)
				end,
			},
		})
	end
}

