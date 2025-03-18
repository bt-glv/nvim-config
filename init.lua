
km 	= vim.keymap.set
cmd = vim.cmd
require('buffer_settings')
require('remaps_tools')
require('remaps')

require("lazy_bootstrap")
require("lazy").setup({

require('colorscheme.catppuccin'),
require('plugin.surround'),
require('plugin._leap'),
require('plugin._flash'),
require('plugin.treesitter'),
require('plugin.lsp0'),
require('plugin._telescope'),
require('plugin.oil'),
require('plugin.neo_tree'),
require('plugin.harpoon2'),
require('plugin.undotree'),
require('plugin.wilder'),
require('ui._tabby'),
require('ui._gitsigns'),
require('plugin.diffview'),
require('plugin._neogit'),
require('plugin.treesitter_textobjects'),
-- require('plugin.obsidian')
-- require('plugin.copilot'),
-- require('plugin.copilotChat'),

})
