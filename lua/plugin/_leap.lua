
return {
    'ggandor/leap.nvim',
    dependencies = {
		'tpope/vim-repeat',
	},

    config = function()
		--[[
		TIPS & HINTS:

		- Press <Cr> (enter) after pressing "s" to repeat the last leap
		- Press <Cr> right after imputing the two characters to go to the nearest match
		- Do do a one character leap do: ("c" represents the character) sc<Cr>

		> ':help leap' for more useful stuff
		--]]--

		local leap = require('leap')
        leap.create_default_mappings()
		leap.opts.vim_opts['go.ignorecase'] = true

        km("v","s",      "<Plug>(leap-forward-till)")
        km("v","S",      "<Plug>(leap-backward-till)")
		km("n", "<A-s>", "<Plug>(leap-from-window)")

		-- km("n", "<A-s>", "<Plug>(leap-anywhere)") -- leaps to any pane
		km("n", "<A-d>", "<Plug>(leap-forward-till)") -- one character behind selection
		km("n", "<A-D>", "<Plug>(leap-backward-till)") -- one character behind selection
        -- km("v","s",      "<Plug>(leap-forward)")
        -- km("v","S",      "<Plug>(leap-backward)")

		-- require('leap.user').set_repeat_keys('<enter>', '<backspace>')
		-- repeats the previous motion without invoking leap
		-- i cant figure out a good set of keys to map this to
	end,

	keys = {
		{'s', nil, mode = 'n'},
		{'S', nil, mode = 'n'},
		{'s', nil, mode = 'v'},
		{'S', nil, mode = 'v'},
	}
}


