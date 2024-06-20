
return {
  'folke/flash.nvim',
  lazy = false,
  config = function()
	require("flash").setup({
	{
	  labels = "asdfghjklqwertyuiopzxcvbnm",
	  search = {
    multi_window = true,
    forward = true,
    wrap = true,
    mode = "exact",
    incremental = false,
    exclude = {
      "notify",
      "cmp_menu",
      "noice",
      "flash_prompt",
      function(win)
        return not vim.api.nvim_win_get_config(win).focusable
      end,
    },
    trigger = "",
    max_length = false, ---@type number|false
  },
  jump = {
    jumplist = true,
    pos = "start", ---@type "start" | "end" | "range"
    history = false,
    register = false,
    nohlsearch = false,
    autojump = false,
    inclusive = nil, ---@type boolean?
    offset = nil, ---@type number
  },
  label = {
    uppercase = true,
    exclude = "",
    current = true,
    after = true, ---@type boolean|number[]
    before = false, ---@type boolean|number[]
    style = "overlay", ---@type "eol" | "overlay" | "right_align" | "inline"
    reuse = "lowercase", ---@type "lowercase" | "all" | "none"
    distance = true,
    min_pattern_length = 0,
    rainbow = {
      enabled = false,
      shade = 5,
    },
    format = function(opts)
      return { { opts.match.label, opts.hl_group } }
    end,
  },
  highlight = {
    backdrop = true,
    matches = true,
    priority = 5000,
    groups = {
      match = "FlashMatch",
      current = "FlashCurrent",
      backdrop = "FlashBackdrop",
      label = "FlashLabel",
    },
  },
  action = nil,
  pattern = "",
  continue = false,
  config = nil, ---@type fun(opts:Flash.Config)|nil
  modes = {
    search = {
      enabled = false,
      highlight = { backdrop = false },
      jump = { history = true, register = true, nohlsearch = true },
      search = {
      },
    },
    char = {
      enabled = true,
      config = function(opts)
        opts.autohide = opts.autohide or (vim.fn.mode(true):find("no") and vim.v.operator == "y")

        opts.jump_labels = opts.jump_labels
          and vim.v.count == 0
          and vim.fn.reg_executing() == ""
          and vim.fn.reg_recording() == ""

      end,
      autohide = false,
      jump_labels = true,
      multi_line = true,
      label = { exclude = "hjkliardc" },
      keys = { "f", "F", "t", "T", ";", "," },
      char_actions = function(motion)
        return {
          [";"] = "next", -- set to `right` to always go right
          [","] = "prev", -- set to `left` to always go left
          [motion:lower()] = "next",
          [motion:upper()] = "prev",
        }
      end,
      search = { wrap = false },
      highlight = { backdrop = true },
      jump = { register = false },
    },
    treesitter = {
      labels = "abcdefghijklmnopqrstuvwxyz",
      jump = { pos = "range" },
      search = { incremental = false },
      label = { before = true, after = true, style = "inline" },
      highlight = {
        backdrop = false,
        matches = false,
      },
    },
    treesitter_search = {
      jump = { pos = "range" },
      search = { multi_window = true, wrap = true, incremental = false },
      remote_op = { restore = true },
      label = { before = true, after = true, style = "inline" },
    },
    remote = {
      remote_op = { restore = true, motion = true },
    },
  },
  prompt = {
    enabled = true,
    prefix = { { "⚡", "FlashPromptIcon" } },
    win_config = {
      relative = "editor",
      width = 1, -- when <=1 it's a percentage of the editor width
      height = 1,
      row = -1, -- when negative it's an offset from the bottom
      col = 0, -- when negative it's an offset from the right
      zindex = 1000,
    },
  },
  remote_op = {
    restore = false,
    motion = false,
  },
}

	})

	-- Keymaps
	kmnc("<c-s>", '<cmd>lua require("flash").toggle()<cr>')
end
} -- Config table end
