
return {
  "NeogitOrg/neogit",
  cmd = "Neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration
    "nvim-telescope/telescope.nvim", -- optional
  },
  config = (function()
		cmd("command! Ng Neogit")
		return true
  end)()
}
