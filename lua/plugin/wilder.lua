
return {
	'gelguy/wilder.nvim',
	lazy = false,
	config = function()

		local wilder = require('wilder')
		wilder.setup({ modes = { '/', '?',':', }, })

		-- Set command palette renderer
		--[[
		wilder.set_option('renderer', wilder.popupmenu_renderer(
		  wilder.popupmenu_palette_theme({
			-- 'single', 'double', 'rounded' or 'solid'
			-- can also be a list of 8 characters, see :h wilder#popupmenu_palette_theme() for more details
			border = 'rounded',
			max_height = '75%',      -- max height of the palette
			min_height = 0,          -- set to the same as 'max_height' for a fixed height window
			prompt_position = 'top', -- 'top' or 'bottom' to set the location of the prompt
			reverse = 0,             -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
		  })
		))
		]]--

		-- Set popupmenu renderer
		--[[
		wilder.set_option('renderer', wilder.popupmenu_renderer({
		  -- highlighter applies highlighting to the candidates
		  highlighter = wilder.basic_highlighter(),
		}))
		]]--

	end -- END Config function 
}
