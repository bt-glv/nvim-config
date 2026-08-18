
return {
	'williamboman/mason.nvim',
	enabled = function() return not Disable_lsp end,
	lazy    = false,
	dependencies = {
		'williamboman/mason-lspconfig.nvim',
		'neovim/nvim-lspconfig',
	},
	config = function()
		require('mason').setup({})
		require('mason-lspconfig').setup({
			automatic_enable = true,
			ensure_installed = Lsp_servers.mason_autoinstall,
			handlers = {
				function(server_name)
					-- require('lspconfig')[server_name].setup({})
					vim.lsp.enable(server_name)
				end,
			},
		})
	end
}

