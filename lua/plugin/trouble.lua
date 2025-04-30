
return {
  "folke/trouble.nvim",
  opts = {},
  cmd = "Trouble",
  keys = {
    {
	-- trouble diagnostics
      "<leader>td",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
	-- trouble diagnostics here
      "<leader>tD",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
	-- trouble symbols
      "<leader>ts",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
	-- trouble definitions
      "<leader>tf",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
	-- trouble loclist
      "<leader>tl",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
	-- trouble quickfix
      "<leader>tq",
      "<cmd>Troub e qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  },
}


