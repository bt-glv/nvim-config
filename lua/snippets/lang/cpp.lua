local ls          = require('luasnip')
local vscode_snip = ls.parser.parse_snippet
local fmt         = require('luasnip.extras.fmt').fmt
local extras      = require('luasnip.extras')
local s           = ls.snippet
local t           = ls.text_node
local i           = ls.insert_node
local f           = ls.function_node
local l           = extras.l
local rep         = extras.rep

return {
	s("header def", fmt([[
	#ifndef <1>
	#define <1>

		<2>

	#endif
	]],
	{
		f(function()
			return string.upper(string.match(vim.fn.expand("%:t"), "[^.]+"))
		end),
		i(1)
	},
	{delimiters = '<>', repeat_duplicates = true})),

}
