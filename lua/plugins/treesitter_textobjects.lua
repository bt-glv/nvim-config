
return {
    'nvim-treesitter/nvim-treesitter-textobjects',

	dependencies = {"nvim-treesitter/nvim-treesitter"},
    lazy         = false,
    priority     = 100,
	branch       = "main",
	build        = ":TSUpdate",

	init = function()
		vim.g.no_plugin_maps = true
	end,

    config = function()
		-- configuration
		require("nvim-treesitter-textobjects").setup {
		  select = {
			lookahead = true,
			selection_modes = {
			  ['@parameter.outer'] = 'v', -- charwise
			  ['@function.outer'] = 'V', -- linewise
			  -- ['@class.outer'] = '<c-v>', -- blockwise
			},
			include_surrounding_whitespace = false,
		  },
		}

		-- SELECT
		-- You can use the capture groups defined in `textobjects.scm`

		-- mini.ai textobjects uses those charactes:
		-- ?, *, q, t, f, a

		-- vim.keymap.set({ "x", "o" }, "am", function()
		--   require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
		-- end)
		-- vim.keymap.set({ "x", "o" }, "im", function()
		--   require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")
		-- end)
		-- vim.keymap.set({ "x", "o" }, "ac", function()
		--   require "nvim-treesitter-textobjects.select".select_textobject("@class.outer", "textobjects")
		-- end)
		-- vim.keymap.set({ "x", "o" }, "ic", function()
		--   require "nvim-treesitter-textobjects.select".select_textobject("@class.inner", "textobjects")
		-- end)
		-- vim.keymap.set({ "x", "o" }, "as", function()
		--   require "nvim-treesitter-textobjects.select".select_textobject("@local.scope", "locals")
		-- end)



		--
		-- MOVE
		-- << WIP >>

		-- function
		vim.keymap.set({ "n", "x", "o" }, "[m", function()
		  require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
		end)
		vim.keymap.set({ "n", "x", "o" }, "]m", function()
		  require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
		end)
		--------
		vim.keymap.set({ "n", "x", "o" }, "[M", function()
		  require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
		end)
		vim.keymap.set({ "n", "x", "o" }, "]M", function()
		  require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
		end)


		-- local scope
		vim.keymap.set({ "n", "x", "o" }, "[s", function()
		  require("nvim-treesitter-textobjects.move").goto_previous_start("@local.scope", "locals")
		end)
		vim.keymap.set({ "n", "x", "o" }, "]s", function()
		  require("nvim-treesitter-textobjects.move").goto_next_end("@local.scope", "locals")
		end)
		--------
		vim.keymap.set({ "n", "x", "o" }, "[S", function()
		  require("nvim-treesitter-textobjects.move").goto_next_start("@local.scope", "locals")
		end)
		vim.keymap.set({ "n", "x", "o" }, "]S", function()
		  require("nvim-treesitter-textobjects.move").goto_previous_end("@local.scope", "locals")
		end)


		-- class
		vim.keymap.set({ "n", "x", "o" }, "]]", function()
		  require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
		end)

		vim.keymap.set({ "n", "x", "o" }, "][", function()
		  require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
		end)

		vim.keymap.set({ "n", "x", "o" }, "[[", function()
		  require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
		end)

		vim.keymap.set({ "n", "x", "o" }, "[]", function()
		  require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
		end)


		-- fold
		vim.keymap.set({ "n", "x", "o" }, "]z", function()
		  require("nvim-treesitter-textobjects.move").goto_next_start("@fold", "folds")
		end)

		-- conditional
		vim.keymap.set({ "n", "x", "o" }, "]d", function()
		  require("nvim-treesitter-textobjects.move").goto_next("@conditional.outer", "textobjects")
		end)
		vim.keymap.set({ "n", "x", "o" }, "[d", function()
		  require("nvim-treesitter-textobjects.move").goto_previous("@conditional.outer", "textobjects")
		end)


		--
		-- SWAP
		-- << WIP >>

		vim.keymap.set("n", "<leader>a", function()
		  require("nvim-treesitter-textobjects.swap").swap_next "@parameter.inner"
		end)
		vim.keymap.set("n", "<leader>A", function()
		  require("nvim-treesitter-textobjects.swap").swap_previous "@parameter.outer"
		end)

    end
}
