
local function main()
	cmd('command! FirenvimInstall call firenvim#install(0) ')
	vim.g.firenvim_config = {
		globalSettings = {
		  ['<C-w>'] = 'noop',
		  ['<C-n>'] = 'default'
		}
	}
end

local function error_handler(err)
	if not Show_full_errors then err = "" end
	print("\n\n<<  ERROR  >>\nFireNvim -> error processing main function/config\n\n" .. err) end

-- Exec
plugin_add([[
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
]])

plugin_add_config(function() xpcall(main, error_handler) end)
-- ATTENTION
-- Fully restart your browser in order for the plugin to work
-- Its recommended to unbind <c-w> in firefox
