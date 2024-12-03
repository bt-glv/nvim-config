
return {
	'nanozuki/tabby.nvim',
	lazy = false,
	dependencies = {},
	config = function()

		local theme = {
		  current = { fg = "#cad3f5", bg = "transparent", style = "bold" },
		  not_current = { fg = "#5b6078", bg = "transparent" },

		  fill = { bg = "transparent" },
		}

		-- Not an ideal solution; I didn't find a way to set a default tab name
		local function redefine_default_tab_name(tab_name, tab_number)
			if tab_name == "[No Name]" or tab_name == nil or tab_name == "" then
				return "["..tab_number.."]"
			end
			return tab_name
		end

		require("tabby.tabline").set(function(line)
		  return {
			line.tabs().foreach(function(tab)
			  local hl = tab.is_current() and theme.current or theme.not_current
			  return {
				line.sep(" ", hl, theme.fill),
				redefine_default_tab_name( tab.name(), tab.number() ),
				line.sep(" ", hl, theme.fill),
				hl = hl,
			  }
			end),
			line.spacer(),
			hl = theme.fill,
		  }
		end)

		-- Remaps
		km("n","<leader>tr", ":Tabby rename_tab ")

	end -- END Config function 
}
