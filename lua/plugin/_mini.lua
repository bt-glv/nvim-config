
return {
	"nvim-mini/mini.nvim",
	dependencies = {
		'nvim-treesitter/nvim-treesitter-textobjects'
	},
	version      = '*',
	lazy         = false,

	config = function()

		-- Similar to: https://github.com/junegunn/vim-easy-align
		require('mini.align').setup( {
			mappings = {
				start              = 'ga',
				start_with_preview = 'gA',
			},
		})

			-- No need to copy this inside `setup()`. Will be used automatically.
		require('mini.surround').setup({
				-- Add custom surroundings to be used on top of builtin ones. For more
				-- information with examples, see `:h MiniSurround.config`.
				custom_surroundings = nil,

				-- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
				highlight_duration = 500,

				-- Module mappings. Use `''` (empty string) to disable one.
				mappings = {
					add            = '<leader>sa', -- Add surrounding in Normal and Visual modes
					delete         = '<leader>sd', -- Delete surrounding
					replace        = '<leader>sr', -- Replace surrounding

					find           = "", -- '<leader>sf', -- Find surrounding (to the right)
					find_left      = "", -- '<leader>sF', -- Find surrounding (to the left)
					highlight      = "", -- '<leader>sh', -- Highlight surrounding
					suffix_last    = "", --'<leader>l',  -- Suffix to search with "prev" method
					suffix_next    = "", -- '<leader>n',  -- Suffix to search with "next" method
					update_n_lines = "", -- '<leader>sn', -- Update `n_lines`
				},

				-- Number of lines within which surrounding is searched
				n_lines = 20,

				-- Whether to respect selection type:
				-- - Place surroundings on separate lines in linewise mode.
				-- - Place surroundings on each line in blockwise mode.
				respect_selection_type = false,

				-- How to search for surrounding (first inside current line, then inside
				-- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
				-- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
				-- see `:h MiniSurround.config`.
				search_method = 'cover',

				-- Whether to disable showing non-error feedback
				-- This also affects (purely informational) helper messages shown after
				-- idle time if user input is required.
				silent = false,
		})

		require"mini.indentscope".setup({
			draw = { predicate = function() return false end, },

			mappings = {
				object_scope             = "ii",
				object_scope_with_border = "ai",
				goto_top                 = "[i",
				goto_bottom              = "]i",
			},
			options = {
				border           = "both",
				n_lines          = 10000,
				indent_at_cursor = true,
				try_as_border    = false,
			},
		})

		-- mini.ai is unreliable for treesitter queries
		local ai = require"mini.ai"
		ai.setup({
			n_lines = 500,
			custom_textobjects = {
				-- Wire Tree-sitter AST queries into mini.ai text objects!
				o = ai.gen_spec.treesitter({
					a = { "@block.outer", "@conditional.outer", "@loop.outer" },
					i = { "@block.inner", "@conditional.inner", "@loop.inner" },
				}),
				f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
				c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
				t = ai.gen_spec.treesitter({ a = "@comment.outer", i = "@comment.outer" }),
			},
		})


	end,
}
