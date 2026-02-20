return {
	-- :Mason
	-- the name to the right of the lsp server name
	mason_lsp_servers = {
		-- "lua_ls", 	-- better if installed locally
		-- "ts_ls", 	-- better if installed locallly
		"angularls",
		"pyright",
		"html",
		"gopls",
		"bashls",
		"cssls",
		'kotlin_language_server',
		"jdtls",         -- Java
		'clangd',        -- c
		-- 'markdown_oxide' // does not work on nixos with mason
	},


	-- accepted lsp names:
	-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
	local_lsp_servers = {
		"lua_ls",
		"ts_ls", 	     -- Javascript & typescript
		"nixd", 	     -- Nixos nix lsp
		'markdown_oxide' -- markdown
	},


	setup = function(self)

		vim.diagnostic.enable()
		vim.diagnostic.config({
			virtual_lines=false,
			signs=false,
		})

		-- keymaps and user commands
		km('n', "<leader>ll", function() self.toggle_virtual_line(true) end)
		km('n', "<leader>l;", function() self.toggle_diagnostics(false) end)

		-- missing neovim lsp mappings
		km('n', 'gd',         function() vim.lsp.buf.definition()       end)

		vim.api.nvim_create_user_command("DiagnosticToggle",   function() self.toggle_diagnostics() end,  {})
		vim.api.nvim_create_user_command("VirtualLineToggele", function() self.toggle_virtual_line() end, {})
		vim.api.nvim_create_user_command("RestartLspServers",  function() self.RestartLspServers() end,   {})
	end,

	local_lsp_init = function(self)
		for _, server in ipairs(self.local_lsp_servers) do
			vim.lsp.enable(server)
		end
	end,

	toggle_diagnostics = function(silent)
		if vim.diagnostic.is_enabled() then
			vim.diagnostic.enable(false)
			if not silent then vim.notify('Diagnostics disabled') end
			return
		end
		vim.diagnostic.enable()
		if not silent then vim.notify('Diagnostics enabled') end
	end,

	toggle_virtual_line = function(silent)
		if vim.diagnostic.config().virtual_lines then
			vim.diagnostic.config({ virtual_lines = false })
			if not silent then vim.notify('Virtual line disabled') end
			return
		end
		vim.diagnostic.config({ virtual_lines = true })
		if not silent then vim.notify('Virtual line enabled') end
	end,

	RestartLspServers = function()
		local lsp_clients = vim.lsp.get_active_clients()
		for _, client in pairs(lsp_clients) do vim.cmd("LspRestart "..client.id); end
		print("All lsp clients restarted")
	end,

}
