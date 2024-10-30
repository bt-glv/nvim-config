
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



		local function Parse_termcodes(key)
			return vim.api.nvim_replace_termcodes(key, true, false, true)
		end

		local esc 	= Parse_termcodes("<Esc>")
		-- local cr 	= Parse_termcodes("<CR>")

		local function manual_surround()

				local function invert_simple(input_end)
					input_end = string.gsub(input_end,'%[',']')
					input_end = string.gsub(input_end,'%(',')')
					input_end = string.gsub(input_end,'%{','}')
					return input_end
				end
				-- #TODO: Add tag detection with vim regex and handle it 

				local function invert_vimscript()
					-- #TODO: remake invert_simple using vim regex
				end

				local input 		= vim.fn.input('>')
				local input_end 	= invert_simple(input)
				return			 	  esc.."`>a"..input_end..esc.."`<i"..input..esc.."lm<".."`>"..#input.."lm>"
		end

		local function action()
				vim.api.nvim_feedkeys(manual_surround(), "i", false)
		end

		kmnv("<leader>x", function() action() end)
		kmnv("<leader>S", function() action() end)

		-- I made this to kind of fill the role of a two character or more surround command.
		-- Use surround with tag, then run this command
	end, -- END Config function
}
