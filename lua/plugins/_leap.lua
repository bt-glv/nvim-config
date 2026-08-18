
return {

	-- The maintainer moved the repo from github to codeberg
	url          = "https://codeberg.org/andyg/leap.nvim",
	dependencies = { 'tpope/vim-repeat', },

	config = function()
		--[[
		TIPS & HINTS:

		- Press <Cr> (enter) after pressing "s" to repeat the last leap
		- Press <Cr> right after imputing the two characters to go to the nearest match
		- Do do a one character leap do: ("c" represents the character) sc<Cr>

		> ':help leap' for more useful stuff
		--]]--

		local leap = require('leap')
		leap.opts.vim_opts['go.ignorecase'] = true

		km({'n', 'x', 'o'}, 's', '<Plug>(leap-forward)')
		km('n',             'S', '<Plug>(leap-backward)')

		km("v","s",      "<Plug>(leap-forward-till)")
		km("v","S",      "<Plug>(leap-backward-till)")
		km("n","<A-s>",  "<Plug>(leap-from-window)")

		-- km("n", "<A-s>", "<Plug>(leap-anywhere)") -- leaps to any pane
		km("n", "<A-d>", "<Plug>(leap-forward-till)") -- one character behind selection
		km("n", "<A-D>", "<Plug>(leap-backward-till)") -- one character behind selection

		-- repeats the previous motion without invoking leap
		-- i cant figure out a good set of keys to map this to
		-- require('leap.user').set_repeat_keys('<enter>', '<backspace>')
	end,

	keys = {
		{'s', nil, mode = 'n'},
		{'S', nil, mode = 'n'},
		{'s', nil, mode = 'v'},
		{'S', nil, mode = 'v'},
	}
}


