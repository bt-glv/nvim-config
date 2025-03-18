
--
-- If you need a tutorial, watch this video
-- https://www.youtube.com/watch?v=FuYQ7M73bC0&t=58s
--

return {
	'nvim-treesitter/nvim-treesitter-textobjects',
	lazy = false,
	dependencies = {"nvim-treesitter/nvim-treesitter"},
	priority = 100,
	config = function()
		require'nvim-treesitter.configs'.setup {
		  textobjects = {
			select = {
			  enable = true,
			  lookahead = true,
			  keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
				["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
			  },
			  selection_modes = {
				['@parameter.outer'] = 'v', -- charwise
				['@function.outer'] = 'V', -- linewise
				['@class.outer'] = '<c-v>', -- blockwise
			  },
			  include_surrounding_whitespace = true,
			},

			move = {
				  enable = true,
				  set_jumps = true, -- whether to set jumps in the jumplist
				  goto_next_start = {
					["]m"] = "@function.outer",
					["]]"] = { query = "@class.outer", desc = "Next class start" },
					["]o"] = "@loop.*",
					["]s"] = { query = "@local.scope", query_group = "locals", desc = "Next scope" },
					["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
				  },
				  goto_next_end = {
					["]M"] = "@function.outer",
					["]["] = "@class.outer",
				  },
				  goto_previous_start = {
					["[m"] = "@function.outer",
					["[["] = "@class.outer",
				  },
				  goto_previous_end = {
					["[M"] = "@function.outer",
					["[]"] = "@class.outer",
				  },
				  goto_next = {
					["]d"] = "@conditional.outer",
				  },
				  goto_previous = {
					["[d"] = "@conditional.outer",
				  }
				},

			  },



		}
	end -- END Config function
}
