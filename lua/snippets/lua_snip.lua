
function SnipAdd()
	local ls = require('luasnip')
	local s = ls.snippet
	local t = ls.text_node
	local i = ls.insert_node

	local _lua = {
		s("phw", {
			t('print("hello world")')
		}),
	}
	ls.add_snippets("lua",  _lua)
end

return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	build = "make install_jsregexp", -- install jsregexp (optional!).
	lazy = false,
	dependencies = {
		-- "rafamadriz/friendly-snippets", -- pre-made snippets
	},
	config = function()

		local ls = require'luasnip'
		local types = require("luasnip.util.types")
		local s = ls.snippet
		local t = ls.text_node
		local i = ls.insert_node

		-- local luasnip = require("luasnip")
		--
		-- vim.keymap.set({"i", "s"}, "<C-L>", function() luasnip.jump( 1) end, {silent = true})
		-- vim.keymap.set({"i", "s"}, "<C-J>", function() luasnip.jump(-1) end, {silent = true})
		-- vim.keymap.set({"i", "s"}, "<C-E>", function()
		-- 	if luasnip.choice_active() then
		-- 		luasnip.change_choice(1)
		-- 	end
		-- end, {silent = true})


		-- possible legacy way of doing this
		-- ls.config.set_config()
		ls.setup({
			keep_roots = true,
			link_roots = true,
			link_children = true,

			-- Update more often, :h events for more info.
			update_events = "TextChanged,TextChangedI",
			-- Snippets aren't automatically removed if their text is deleted.
			-- `delete_check_events` determines on which events (:h events) a check for
			-- deleted snippets is performed.
			-- This can be especially useful when `history` is enabled.
			delete_check_events = "TextChanged",
			ext_opts = {
				[types.choiceNode] = {
					active = {
						virt_text = { { "choiceNode", "Comment" } },
					},
				},
			},
			-- treesitter-hl has 100, use something higher (default is 200).
			ext_base_prio = 300,
			-- minimal increase in priority.
			ext_prio_increase = 1,
			enable_autosnippets = true,
			-- mapping for cutting selected text so it's usable as SELECT_DEDENT,
			-- SELECT_RAW or TM_SELECTED_TEXT (mapped via xmap).
			store_selection_keys = "<Tab>",
			-- luasnip uses this function to get the currently active filetype. This
			-- is the (rather uninteresting) default, but it's possible to use
			-- eg. treesitter for getting the current filetype by setting ft_func to
			-- require("luasnip.extras.filetype_functions").from_cursor (requires
			-- `nvim-treesitter/nvim-treesitter`). This allows correctly resolving
			-- the current filetype in eg. a markdown-code block or `vim.cmd()`.
			ft_func = function()
				return vim.split(vim.bo.filetype, ".", true)
			end,
		})

		SnipAdd()
		require("luasnip.loaders.from_vscode").lazy_load()
	end,
}

