
return {
	'junegunn/fzf.vim',
	lazy = false,
	-- build = function() vim.fn['fzf#install']() end,
	dependencies = {
		{'junegunn/fzf',build = function() vim.fn['fzf#install']() end }
	},
	config = function()
		km("n", "<leader>ff", 	":Files<CR>") 		-- Fuzzy finds and open file 
		km("n", "<leader>fb", 	":Buffers<CR>") 	-- Fuzzy finds and open buffer
		km("n", "<leader>fl", 	":BLines<CR>") 		-- Fuzzy finds a line in your current text buffer
		km("n", "<leader>fm", 	":Marks<CR>") 		-- Fuzzy finds marks 
		km("n", "<leader>fr", 	":Rg<CR>") 		-- Finds files that contain a ripgrep match
		km("n", "<leader>fg", 	":Ag<CR>")
	end
}
