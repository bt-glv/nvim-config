
require('short_commands')
require('buffer_settings')
require('remaps')


require('plugin_management') 		-- Must load before all plugins
Show_full_errors = false

require('colorscheme.catppuccin')
-- require('plugin.firenvim') 		-- Nvim on browsers. Ironically, works best on chromium. Doesnt work with discord or whatsapp on chromium
require('plugin.p_leap')
require('plugin.p_flash')
require('plugin.surround')
require('plugin.treesitter')
require('plugin.lsp0') 				-- Autocomplete and compile-time errors
require('plugin.github_copilot') 	-- "AI Autocomplete"
require('plugin.fzf')
require('plugin.oil') 				-- replaces netrw
require('plugin.neo_tree')
require('plugin.harpoon2')
Plugin_init()
