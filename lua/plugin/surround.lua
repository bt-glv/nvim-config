
local function main()
	-- Disable all default mappings
	-- This is the only reliable way I find to disable 'S' in visual line mode 
	vim.g.surround_no_mappings = true
	cmd([[
		nmap ds  <Plug>Dsurround
		nmap cs  <Plug>Csurround
		nmap cS  <Plug>CSurround
		nmap ys  <Plug>Ysurround
		nmap yS  <Plug>YSurround
		nmap yss <Plug>Yssurround
		nmap ySs <Plug>YSsurround
		nmap ySS <Plug>YSsurround
	]])
	-- I'm using 's' and 'S' for leap, so I'm using z for surround
	kmv("<leader>s", "<Plug>VSurround")
end

local function error_handler(err)
	if not Show_full_errors then err = "" end
	print("\n\n<<  ERROR  >>\nSurround.vim -> error processing main function/config\nMaybe its not installed?\n\n" .. err) end

-- Exec
plugin_add([[
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
]])

plugin_add_config(function() xpcall(main, error_handler) end)
