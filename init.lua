
km 	= vim.keymap.set
cmd = vim.cmd

function openTerminal(path) 
	vim.cmd('silent! !alacritty --working-directory "'..path..'" & disown') end

function openNeovim(path)
	vim.cmd('silent! !alacritty --working-directory "'..path..'" -e bash -c "nvim ." & disown') end

Notify = function(string, priority, opts) 
	vim.notify(string)
end

require('buffer_settings')
require('remap_tools')
require('remaps')

require("lazy_bootstrap")
require("lazy").setup({
	require('plugin._snacks'),
	require('colorscheme.catppuccin'),
	require('plugin.surround'),
	require('plugin._leap'),
	require('plugin._flash'),
	require('plugin.treesitter'),
	require('lsp.lsp0'),
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
	require('ui._tabby'),
	require('ui._gitsigns'),
	require('ui.nvim_web_devicons'),
	require('ui.rainbow_delimiters'),
})

require('checks')
