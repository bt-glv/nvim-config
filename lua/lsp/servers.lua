return {

	mason_autoinstall = {
		-- "lua_ls", 	-- better if installed locally
		-- "ts_ls", 	-- better if installed locallly
		"angularls",
		"pyright",
		"html",
		"gopls",
		"bashls",
		"cssls",
		'kotlin_language_server',
		"jdtls",         	-- Java
		"vimls",
		-- 'clangd',        -- c        // doesn't work on nixos w/ mason
		-- 'markdown_oxide' -- markdown // doesn't work on nixos with mason
	},

	-- accepted lsp names:
	-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
	locally_installed = {
		"lua_ls",
		"ts_ls", 	        -- Javascript & typescript
		"nixd", 	        -- Nixos nix lsp
		'markdown_oxide',   -- markdown
		'clangd',			-- c
	}

}
