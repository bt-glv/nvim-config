return {
	-- :Mason
	-- the name to the right of the lsp server name
	mason_lsp_servers = {
		-- "lua_ls",
		"pyright",
		"html",
		"gopls",
		"bashls",
		"cssls",
		"angularls",
		"ts_ls", -- Javascript & typescript
		"jdtls", -- Java
	},

	-- i'm not sure about the names used in vim.lsp.enable()
	-- they might be the same as mason
	-- This might help
	-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
	local_lsp_servers = {
		'lua_ls',
	},

	setup = function(self)

		vim.diagnostic.enable()
		vim.diagnostic.config({
			virtual_lines=false,
			signs=false,
		})

		-- keymaps and user commands
		km('n', "<leader>ll", function() self.toggle_virtual_line(true) end )
		km('n', "<leader>lsd", function() self.toggle_diagnostics(false) end)

		vim.api.nvim_create_user_command("DiagnosticToggle", function() self.toggle_diagnostics() end, {})
		vim.api.nvim_create_user_command("VirtualLineToggele", function() self.toggle_virtual_line() end, {})
		vim.api.nvim_create_user_command("RestartLspServers", function() self.RestartLspServers() end, {})
	end,

	local_lsp_init = function(self)
		for _, server in ipairs(self.local_lsp_servers) do
			vim.lsp.enable(server)
		end
	end,

	toggle_diagnostics = function(silent)
		if vim.diagnostic.is_enabled() then
			lsp_diag_toggle = false
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
