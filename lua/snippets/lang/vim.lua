local ls     = require('luasnip')
local fmt    = require('luasnip.extras.fmt').fmt
local extras = require('luasnip.extras')
local s      = ls.snippet
local t      = ls.text_node
local i      = ls.insert_node
local f      = ls.function_node
local c      = ls.choice_node
local rep    = extras.rep
local l      = require("luasnip.extras").l

-- TODO
-- WIP
return {
	s("rep", fmt([[
	<>/<>/<>/g
	]],
	{
		c(1, {
			t([[%s]]),    -- global scope
			t([[s]]),     -- global scope
			t([['<,'>s]]) -- visual mode local scope 
		}),

		c(2, {
			f(function() return vim.fn.getreg('/') end),
			i(),
		}),

		i(3),
	},
	{delimiters = '<>', repeat_duplicates = true})),


	s("'<,'>vrep", fmt([[
	'<,'>s/{}/{}/g
	]],
	{
		c(1, {
			f(function() return vim.fn.getreg('/') end),
			i(),
		}),

		i(2),
	},
	{delimiters = '{}', repeat_duplicates = true}))



}
