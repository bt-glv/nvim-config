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

	s("objstruct", fmt([[
	typedef struct <b> <a>;
	struct <b> {
		<>
	};
	<a>* <a>_constructor(<>) {
		<a>* out = (<a>*) malloc(sizeof(<a>));
		
		return out;
	};
	]],
	{
		a = i(1),
		b = l("_" .. l._1, 1),
		i(2),
		i(3)
	},
	{delimiters = '<>', repeat_duplicates = true})),

	s("include default", fmt([[
		#include <stdio.h>
		#include <stdlib.h>
		#include <ctype.h>
		#include <stdbool.h>


	]],
	{},
	{delimiters = '{}', repeat_duplicates = true}))

}
