
return {
	'nvim-neo-tree/neo-tree.nvim',
	lazy = false,
	dependencies = {'nvim-lua/plenary.nvim', 'MunifTanjim/nui.nvim'},
	config = function()
		kmn( "<leader>pv", ":Neotree toggle<cr>")
	end -- END Config function 
}
