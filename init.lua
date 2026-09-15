
vim.o.grepprg = 'rg --vimgrep'
km            = vim.keymap.set
cmd           = vim.cmd
SystemOS      = vim.loop.os_uname().sysname

-- Dependency checks may slowdown startup times
-- Set to false if neovim is taking too long to start
No_Dependency_Checks = false

Disable_treesitter     = false
Treesitter_parsers     = require'treesitter.parsers'
Treesitter_tools       = require'treesitter.tools'

Disable_lsp = false
Lsp_servers = require'lsp.servers'
Lsp_tools   = require'lsp.tools'

Tools = require('tools')

require('terminal')
require('buffer_settings')
require('remaps')


require("lazy_bootstrap")
require("lazy").setup({
	require('colorscheme.catppuccin'),

	require('treesitter.plugin.nvim-treesitter'), -- should go after catppuccin

	require('ui.plugin._treesitter_context'),
	require('ui.plugin.render_markdown'),

	require('lsp.plugin._lspconfig'),
	require('lsp.plugin._mason'),
	require('lsp.plugin.nvim_cmp'),
	require('lsp.plugin._lazydev'),
	require('lsp.plugin.trouble'),
	require('lsp.plugin.nvim-jdtls'),
	require('debug.plugin.nvim-dap'),
	require('snippets.plugin.lua_snip'),

	require('ui.plugin._tabby'),
	require('ui.plugin._gitsigns'),
	require('ui.plugin.nvim_web_devicons'),
	require('ui.plugin.rainbow_delimiters'),
	require('ui.plugin.nvim_autopairs'),
	require('ui.plugin.nvim_ufo'),

	require('plugins._mini'),
	require('plugins._snacks'),
	require('plugins._leap'),
	require('plugins._flash'),
	require('plugins._telescope'),
	require('plugins.oil'),
	require('plugins.neo_tree'),
	require('plugins.harpoon2'),
	require('plugins.undotree'),
	require('plugins.diffview'),
	require('plugins._neogit'),
})

require('checks')

Treesitter_tools.init()

