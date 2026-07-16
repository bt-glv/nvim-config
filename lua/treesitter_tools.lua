
--- @return table {} helper table for treesitter related actions
--- @warning work in progress
--- @warning TODO
return {
	init = function()
		vim.api.nvim_create_autocmd('FileType', {
		  callback = function()
			-- Enable native Treesitter highlighting (and fallback gracefully if parser is missing)
			pcall(vim.treesitter.start)

			-- Enable treesitter-based indentation
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		  end,
		})
	end
}

