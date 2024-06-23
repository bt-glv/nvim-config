
return {
	'tpope/vim-surround',
	lazy = false,
	dependencies = {'tpope/vim-repeat'},
	init = function() vim.g.surround_no_mappings = true end,
	config = function()
		-- Disable all default mappings
		-- This is the only reliable way I find to disable 'S' in visual line mode 
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
		kmv("<leader>s", "<Plug>VSurround")
	end, -- END Config function 
}
