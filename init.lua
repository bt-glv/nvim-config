
vim.o.grepprg = 'rg --vimgrep'
km            = vim.keymap.set
cmd           = vim.cmd

require('tools')
require('buffer_settings')
require('remaps')

lsp_settings     = require('lsp.settings')
treesitter_tools = require('treesitter_tools')

require("lazy_bootstrap")
require("lazy").setup({
	require('colorscheme.catppuccin'),

	require('ui.nvim-treesitter'), -- should go after catppuccin
	require('ui._treesitter_context'),
	require('ui.render_markdown'),
	require('plugin.treesitter_textobjects'),

	require('lsp._lspconfig'),
	require('lsp._mason'),
	require('lsp.nvim_cmp'),
	require('lsp._lazydev'),
	require('lsp.trouble'),
	require('lsp.nvim-jdtls'),
	require('snippets.lua_snip'),
	require('ui._tabby'),
	require('ui._gitsigns'),
	require('ui.nvim_web_devicons'),
	require('ui.rainbow_delimiters'),
	require('ui.nvim_autopairs'),
	require('ui.nvim_ufo'),
	require('plugin._snacks'),
	require('plugin._leap'),
	require('plugin._flash'),
	require('plugin._telescope'),
	require('plugin.oil'),
	require('plugin.neo_tree'),
	require('plugin.harpoon2'),
	require('plugin.undotree'),
	require('plugin.diffview'),
	require('plugin._neogit'),
	require('debug.nvim-dap'),
	require('plugin._mini'),

})
require('checks')

treesitter_tools.init() -- not sure where this should go

