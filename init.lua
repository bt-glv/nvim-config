
require('short_commands')
require('buffer_settings')
require('remaps')


require('plugin_management') -- Must load before all plugins

require('colorscheme.catppuccin')
require('plugin.others')
require('plugin.treesitter')
require('plugin.lsp0')
require('plugin.fzf')
Plugin_init()

