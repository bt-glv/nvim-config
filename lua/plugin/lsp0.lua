
local function main() 

	local lsp_zero = require('lsp-zero')

	lsp_zero.on_attach(function(client, bufnr)
	  -- see :help lsp-zero-keybindings
	  -- to learn the available actions
	  lsp_zero.default_keymaps({buffer = bufnr})
	end)

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

end


local function error_handler(err)
	print("\n\n<<  ERROR  >>\nlsp0 -> error processing main function/config\nlsp0 might not be installed or plug statement didn't execute yet\n\n" .. err)
	return "lsp0 -> error processing main function/config"
end



-- Exec

plugin_add([[
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'L3MON4D3/LuaSnip'
Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v3.x'}
]])

plugin_add_config(function() xpcall(main, error_handler) end)



