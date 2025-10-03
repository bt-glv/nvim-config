
local ls = require('luasnip')
local vscode_snip = ls.parser.parse_snippet
local fmt = require('luasnip.extras.fmt').fmt
local extras = require('luasnip.extras')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = extras.rep

return {
	s('dfunc', fmt([[
		class <a> {
			<> exec(<>) {
				<>
			}
		}; <a> <> = new <a>();
	]],
	{ a = i(1), i(3), i(4), i(5), i(2), },
	{delimiters = '<>', repeat_duplicates = true}))

	,vscode_snip('Snippet Lua Require',[[
		local ls = require('luasnip')
		local vscode_snip = ls.parser.parse_snippet
		local fmt = require('luasnip.extras.fmt').fmt
		local extras = require('luasnip.extras')
		local s = ls.snippet
		local t = ls.text_node
		local i = ls.insert_node
		local rep = extras.rep

		$1
	]])

	,vscode_snip('Snippet Lua',[=[
		s("$1", fmt([[
			$2
		]],
		{$3},
		{delimiters = '<>', repeat_duplicates = true}))
	]=])

	,s("pkglazy", fmt([[

		return {
			"<>",
			dependencies = {<>},
			opts = {}
			-- keys = {}
			-- config = function() end
		}
	]],
	{i(1), i(2)},
	{delimiters = '<>', repeat_duplicates = true}))

}
