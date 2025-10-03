
local function add_user_snippets()
	local ls = require('luasnip')
	ls.add_snippets("lua",  require('snippets.lang.lua'))
	ls.add_snippets("java",  require('snippets.lang.java'))
end

return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	build = "make install_jsregexp", -- install jsregexp (optional!).
	dependencies = { "rafamadriz/friendly-snippets", },	-- pre-made snippets
	config = function()
		local types = require("luasnip.util.types")
		require('luasnip').setup(
			{
				keep_roots = true,
				link_roots = true,
				link_children = true,

				update_events = "TextChanged,TextChangedI",
				delete_check_events = "TextChanged",
				ext_opts = {
					[types.choiceNode] = {
						active = {
							virt_text = { { "choiceNode", "Comment" } },
						},
					},
				},
				ext_base_prio = 300,
				ext_prio_increase = 1,
				enable_autosnippets = true,
				store_selection_keys = "<Tab>",
				ft_func = function()
					return vim.split(vim.bo.filetype, ".", true)
				end,
			}
		)

		add_user_snippets()
		require("luasnip.loaders.from_vscode").lazy_load()
	end,
}

