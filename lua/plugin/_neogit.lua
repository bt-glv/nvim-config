
return {
  "NeogitOrg/neogit",
  cmd = { "Neogit", "Ng" },
  keys = { {"<leader>ng", ":Neogit<cr>", "n"} },
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration
    "nvim-telescope/telescope.nvim", -- optional
  },
  config = function()
		vim.cmd("command! Neog Neogit")
		require("neogit").setup{}
  end
}
