
return {
  "epwalsh/obsidian.nvim",
  version 	= "*",  -- recommended, use latest release instead of latest commit

  -- By whatever reason, this is the only approach to arbitrary conditional loading that I had found that actually works.
  lazy 		= (function() return not vim.fn.isdirectory(vim.fn.getcwd().."/.obsidian") == 1 end)(),

  -- ft 		= "markdown",
  -- cond = function()
	-- return vim.fn.isdirectory(vim.fn.getcwd().."/.obsidian") == 1
  -- end,

  config = function()
-- YOU NEED TO SPECIFY YOUR OBSIDIAN DIRECTORIES IN ORDER FOR THIS PLUGIN TO WORK
		vim.opt.conceallevel = 1
		require("obsidian").setup(
			{
				workspaces = {
					{name = "notes_obsidian"	, path = "~/notes_obsidian/"},
					{name = "cs_notes"			, path = "~/cs_obsidian/"}
				},

			  mappings = {
				-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
				["gf"] = {
				  action = function()
					return require("obsidian").util.gf_passthrough()
				  end,
				  opts = { noremap = false, expr = true, buffer = true },
				},
				-- Toggle check-boxes.
				["<leader>o"] = {
				  action = function()
					return require("obsidian").util.toggle_checkbox()
				  end,
				  opts = { buffer = true },
				},
				-- Smart action depending on context, either follow link or toggle checkbox.
				["<cr>"] = {
				  action = function()
					return require("obsidian").util.smart_action()
				  end,
				  opts = { buffer = true, expr = true },
				}
			  }, -- MAPPINGS END HERE
						}) -- SETUP END HERE
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
	"nvim-telescope/telescope.nvim",
	"hrsh7th/nvim-cmp",
	'ggandor/leap.nvim'
  },

	-- obsidian.nvim, for whatever reason, creates a new mapping for "S" in normal mode...
	km("n","S", "<Plug>(leap-backward)")
}
