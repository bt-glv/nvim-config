
require('short_commands')
require('buffer_settings')
require('remaps')

require("lazy_bootstrap")
require("lazy").setup({

require('colorscheme.catppuccin'),
require('plugin.surround'),
require('plugin._leap'),
require('plugin._flash'),
require('plugin.treesitter'),
require('plugin.lsp0'),
require('plugin.copilot'),
require('plugin.copilotChat'),
--require('plugin.fzf'), -- Telescope has better compatibility overall 
require('plugin._telescope'),
require('plugin.oil'),
require('plugin.neo_tree'),
require('plugin.harpoon2'),
require('plugin.undotree'),
require('plugin.wilder'),
require('ui._tabby'),
require('ui._gitsigns'),
require('plugin.diffview'),
require('plugin.neogit'),

})
