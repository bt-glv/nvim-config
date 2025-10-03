
local ls = require('luasnip')
local vscode_snip = ls.parser.parse_snippet
local fmt = require('luasnip.extras.fmt').fmt

local extras = require('luasnip.extras')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = extras.rep

local function nl(tabs, after)
	if(type(tabs) ~= 'number') then
		if after == nil then after = tabs end

		tabs = 0 end
		if(type(after) ~= 'string') then after = "" end

		local out_tabs = ""
		for i = 1, tabs do
			out_tabs = out_tabs.."\t"
		end

		return t({"", out_tabs..after})
end

local temp = s('mfunc', {
	t('class '), i(1), t(' {'),
	nl(1),i(3),t(' exec('),i(4),t(') {'),
	nl(2), i(5),
	nl(1,'}'),
	nl('};'), rep(1), t(' '), i(2), t(' = new '), rep(1),t('();')
})

local temp2 = vscode_snip('xfunc',[[
class $1 {
	$3 exec($4) {
		$5
	}
}; $1 $2 = new $1();
]])

local temp3 = s('dfunc', fmt([[
class <a> {
	<> exec(<>) {
		<>
	}
}; <a> <> = new <a>();
]],
{ a = i(1), i(3), i(4), i(5), i(2), },
{delimiters = '<>', repeat_duplicates = true}))
