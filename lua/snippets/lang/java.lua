
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
	{delimiters = '<>', repeat_duplicates = true})),
	s("finterface", fmt([[
		interface [] <[rty] []> {
			[rty] apply([]);
		}
	]],
	{rty = i(2), i(1), i(2), i(3)},
	{delimiters = '[]', repeat_duplicates = true}))
}

-- Snippet
-- Constructor method snippet
-- nor sure how you would do that

-- Snippet
-- functional interface snippet
-- interface f1 {
-- 	<return type> apply(<params>);
-- }







