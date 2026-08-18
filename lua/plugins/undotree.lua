
return {
	'mbbill/undotree',
	lazy = true,
	cmd = 'UndotreeToggle',
	init = function()
		-- Layout options goes from 1 to 4
		vim.g.undotree_WindowLayout = 4
		vim.g.undotree_SetFocusWhenToggle = 1
		vim.g.undotree_SplitWidth = 40
	end,
	keys = {
		{'<leader>uu', ':UndotreeToggle<CR><CR><CR>'},
	},
	config = function()
		-- TODO: add an autocmd that sets relative line
		-- number if it is a undotree buffer
		-- buffer variable: IsUndoTreeBuffer
	end
}
