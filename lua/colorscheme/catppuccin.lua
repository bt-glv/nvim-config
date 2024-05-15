
local function main()
	require("catppuccin").setup({
	    flavour = "mocha", -- latte, frappe, macchiato, mocha, auto
	    background = { -- :h background
		light = "latte",
		dark = "mocha",
	    },
	    transparent_background = false, -- disables setting the background color.
	    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
	    term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
	    dim_inactive = {
		enabled = false, -- dims the background color of inactive window
		shade = "dark",
		percentage = 0.15, -- percentage of the shade to apply to the inactive window
	    },
	    no_italic = false, -- Force no italic
	    no_bold = false, -- Force no bold
	    no_underline = false, -- Force no underline
	    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
		comments = { "italic" }, -- Change the style of comments
		conditionals = { "italic" },
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
		-- miscs = {}, -- Uncomment to turn off hard-coded styles
	    },
	    color_overrides = { -- Change theme colors here
	    	mocha = {
			base = "#000000",
			-- mantle = "#000000",
			-- crust = "#000000",
		}
	    },
	    custom_highlights = {},
	    default_integrations = true,
	    integrations = {
		cmp = true,
		gitsigns = true,
		nvimtree = true,
		treesitter = true,
		notify = false,
		mini = {
		    enabled = true,
		    indentscope_color = "",
		},
		-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
	    },
	})

	cmd([[colorscheme catppuccin]])
	cmd([[highlight LineNr term=bold cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE]])
end

local function error_handler(err)
	if not Show_full_errors then err = "" end
	print("\n\n<<  ERROR  >>\nPlugin: Catppuccin -> error processing config\nMaybe its not installed?\n\n" .. err) end

-- Exec
plugin_add([[ Plug 'catppuccin/nvim', { 'as': 'catppuccin' } ]])
plugin_add_config(function() xpcall(main, error_handler) end)

