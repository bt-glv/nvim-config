local ls          = require('luasnip')
local vscode_snip = ls.parser.parse_snippet
local fmt         = require('luasnip.extras.fmt').fmt
local extras      = require('luasnip.extras')
local s           = ls.snippet
local t           = ls.text_node
local i           = ls.insert_node
local l           = require("luasnip.extras").l
local rep         = extras.rep

return {

	vscode_snip('snippet require',[[
		local ls          = require('luasnip')
		local vscode_snip = ls.parser.parse_snippet
		local fmt         = require('luasnip.extras.fmt').fmt
		local extras      = require('luasnip.extras')
		local s           = ls.snippet 
		local t           = ls.text_node 
		local i           = ls.insert_node 
		local f           = ls.function_node 
		local c           = ls.choice_node
		local l           = extras.l   -- lambda node
		local rep         = extras.rep -- repeat node

		$1
	]])

	,vscode_snip('snippet',[=[
		s("$1", fmt([[
			$2
		]],
		{$3},
		{delimiters = '<>', repeat_duplicates = true}))
	]=])

	,s("lazy plugin", fmt([[

		return {
			"<>",
			dependencies = {<>},
			-- lazy = false,

			-- opts = {},
			-- config = function() end,

			-- keys  = {
				-- {'<<leader>>ui', nil, mode = 'n'},
			-- },
			-- event = {""},
			-- cmd   = "",
			-- ft    = {
			-- },

			-- main = "nvim-treesitter.configs",
			-- init   = function() end,
		}
	]],
	{i(1), i(2)},
	{delimiters = '<>', repeat_duplicates = true}))

}
