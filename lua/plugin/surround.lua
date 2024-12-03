
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
		km("v", "<leader>s", "<Plug>VSurround")



		-- local function Parse_termc(key)
			-- return vim.api.nvim_replace_termcodes(key, true, false, true)
		-- end

		-- local esc 	= Parse_termc("<Esc>")
		-- local cr 	= Parse_termc("<CR>")


		-- local function action() vim.api.nvim_feedkeys(Manual_surround(), "i", false) end
		-- kmnv("<leader>S", function() action() end)

		-- I made this to kind of fill the role of a two character or more surround command.
		-- Use surround with tag, then run this command
	end, -- END Config function
}
