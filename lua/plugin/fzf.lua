
local function main()
kmn( "<leader>ff", 	":Files<CR>") 		-- Fuzzy finds and open file 
kmn( "<leader>fb", 	":Buffers<CR>") 	-- Fuzzy finds and open buffer
kmn( "<leader>fl", 	":BLines<CR>") 		-- Fuzzy finds a line in your current text buffer
kmn( "<leader>fm", 	":Marks<CR>") 		-- Fuzzy finds marks 
kmn( "<leader>fr", 	":Rg<CR>") 		-- Finds files that contain a ripgrep match
kmn( "<leader>fg", 	":Ag<CR>")
end

local function error_handler(err)
	if not Show_full_errors then err = "" end
	print("\n\n<<  ERROR  >>\nfzf -> error processing main function/config\nMaybe its not installed?\n\n" .. err)
	return "fzf -> error processing main function/config"
end

-- Exec
plugin_add([[
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
]])

plugin_add_config(function() xpcall(main, error_handler) end)



