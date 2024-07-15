
return {
    'nvim-telescope/telescope.nvim',
	branch = '0.1.x',
	lazy =  false,
	priority = 100,
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()

		local actions = require('telescope.actions')
		local action_state = require('telescope.actions.state')
		require('telescope').setup{
		  defaults = {
			mappings = {
			  i = {
				["<C-y>"] = function(prompt_bufnr)
				  local selection = action_state.get_selected_entry()
				  actions.close(prompt_bufnr)
				  vim.api.nvim_command('let @" = @' .. selection.value)
				end,
			  },
			},
		  }
		}

		kmn( "<leader>ff", 	":Telescope find_files<CR>") 		-- Fuzzy finds and open file 
		kmn( "<leader>fb", 	":Telescope buffers<CR>") 	-- Fuzzy finds and open buffer
		kmn( "<leader>fl", 	":Telescope live_grep<CR>") 		-- Fuzzy finds a line in your current text buffer
		kmn( "<leader>fm", 	":Telescope marks<CR>") 		-- Fuzzy finds marks 
		kmn( "<leader>fr", 	":Telescope registers<CR>") 		-- Finds files that contain a ripgrep match
		kmn( "<leader>fh", 	":Telescope current_buffer_fuzzy_find<CR>") 		-- Finds files that contain a ripgrep match

	end
}
