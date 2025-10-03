
function openTerminal(path)
	vim.cmd('silent! !alacritty --working-directory "'..path..'" & disown')
end
function openNeovim(path)
	vim.cmd('silent! !alacritty --working-directory "'..path..'" -e bash -c "nvim ." & disown')
end

Notify = function(string, priority, opts)
	vim.notify(string)
end

km 	= vim.keymap.set
cmd = vim.cmd

lsp_settings = require('lsp.settings')
require('buffer_settings')
require('tools')
require('remaps')

require("lazy_bootstrap")
require("lazy").setup({
	require('colorscheme.catppuccin'),
	require('ui.treesitter'),
	require('lsp._lspconfig'),
	require('lsp._mason'),
	require('lsp.nvim_cmp'),
	require('lsp._lazydev'),
	require('ui._treesitter_context'),
	require('ui._tabby'),
	require('ui._gitsigns'),
	require('ui.nvim_web_devicons'),
	require('ui.rainbow_delimiters'),
	require('plugin._snacks'),
	require('plugin.surround'),
	require('plugin._leap'),
	require('plugin._flash'),
	require('plugin._telescope'),
	require('plugin.oil'),
	require('plugin.neo_tree'),
	require('plugin.harpoon2'),
	require('plugin.undotree'),
	require('plugin.wilder'),
	require('plugin.diffview'),
	require('plugin._neogit'),
	require('plugin.treesitter_textobjects'),
	require('plugin.trouble'),
	require('debug.nvim-dap'),
	require('snippets.lua_snip'),
	require('ui.nvim_autopairs'),
	require('ui.nvim_ufo'),
})
require('checks')

