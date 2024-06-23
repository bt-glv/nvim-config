
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
-- Autocomplete and compile-time errors
require('plugin.copilot'), 			
-- "AI Autocomplete"
require('plugin.copilotChat'), 		
-- "integrated AI chat"
require('plugin.fzf'),
require('plugin.oil'), 				
-- replaces netrw
require('plugin.neo_tree'),
require('plugin.harpoon2'),
require('plugin.undotree'),

})
