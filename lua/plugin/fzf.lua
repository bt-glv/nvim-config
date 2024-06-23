
return {
	'junegunn/fzf.vim',
	lazy = false,
	build = function() vim.fn['fzf#install']() end,
	dependencies = {
		{'junegunn/fzf',run = function() vim.fn['fzf#install']() end }
	},
	config = function()
		kmn( "<leader>ff", 	":Files<CR>") 		-- Fuzzy finds and open file 
		kmn( "<leader>fb", 	":Buffers<CR>") 	-- Fuzzy finds and open buffer
		kmn( "<leader>fl", 	":BLines<CR>") 		-- Fuzzy finds a line in your current text buffer
		kmn( "<leader>fm", 	":Marks<CR>") 		-- Fuzzy finds marks 
		kmn( "<leader>fr", 	":Rg<CR>") 		-- Finds files that contain a ripgrep match
		kmn( "<leader>fg", 	":Ag<CR>")
	end
}
