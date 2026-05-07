local ls          = require('luasnip')
local vscode_snip = ls.parser.parse_snippet
local fmt         = require('luasnip.extras.fmt').fmt
local extras      = require('luasnip.extras')
local s           = ls.snippet
local l           = require("luasnip.extras").l
local t           = ls.text_node
local i           = ls.insert_node
local f           = ls.function_node
local rep         = extras.rep

return {
	s('lecture', fmt([[
	-------
	# lhs





	-------
	# rhs

	>> <> <>




	## q



	-------
	# res

	>> TODO:


	]],
	{
		f(function() return os.date("%H:%M") end, {}),
		i(1)
	},
	{delimiters = '<>', repeat_duplicates = true}
	)),
}
