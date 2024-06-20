
-- LSP0_on_attach_functions = {}
-- 	table.insert(LSP0_on_attach_functions, config_function) end
-- 
-- local function LSP0_on_attach_functions_exec()
-- 	if not next(LSP0_on_attach_functions) then return end
-- 	for i, func in ipairs(LSP0_on_attach_functions) do
-- 		func()
-- 	end
-- end
	  -- pcall(LSP0_on_attach_functions_exec)
	  --https://github.com/VonHeikemen/lsp-zero.nvim.git
return {
	'VonHeikemen/lsp-zero.nvim',
	branch = 'v3.x',
	lazy = false,
	dependencies = {'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim', 'neovim/nvim-lspconfig', 'hrsh7th/nvim-cmp', 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip'},
	config = function()
		local lsp_zero = require('lsp-zero')

		lsp_zero.on_attach(function(client, bufnr)
		  -- see :help lsp-zero-keybindings
		  -- to learn the available actions
		  -- cmd("execute 'buffer ' . "..bufnr.." | let b:copilot_enabled = 1")
		  lsp_zero.default_keymaps({buffer = bufnr})
		end)
		-- you can always install the language server on your system.
		-- in that case, once they are installed, just run lsp config with the name of the installed server
		-- require('lspconfig').server_name.setup({})

		--- if you want to know more about lsp-zero and mason.nvim
		--- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
		require('mason').setup({})
		require('mason-lspconfig').setup({
		  ensure_installed = {
			  "lua_ls", "pyright",
			  "html", "gopls",
			  "tsserver", "bashls",
			  "cssls"
				-- You must input the lspconfig name of the lsp server
				-- Here is a translation list: 
				-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
			},
		  handlers = {
			function(server_name)
			  require('lspconfig')[server_name].setup({})
			end,
		  },
		})

		end -- END Config function 
}
