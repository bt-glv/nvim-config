
require('short_commands')
require('buffer_settings')
require('remaps')


require('plugin_management') -- Must load before all plugins
Show_errors = false

require('colorscheme.catppuccin')
require('plugin.others')
require('plugin.treesitter')
require('plugin.lsp0')
require('plugin.fzf')
require('plugin.oil') -- replaces netrw
Plugin_init()
