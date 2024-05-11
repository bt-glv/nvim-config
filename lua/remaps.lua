--  << Code Utilities >> --
vim.g.mapleader = " "

-- << Remaps by topic >> --
function Remap_QualityOfLife_base()

	-- control space to switch from insert to replace mode
	kmi("<c- >", "<Insert>")

	-- control+hjkl as arrow keys in command mode 
	kmc("<c-h>", "<Left>")
	kmc("<c-j>", "<Down>")
	kmc("<c-k>", "<Up>")
	kmc("<c-l>", "<Right>")
	kmc("<c-b>", "<c-Left>")
	kmc("<c-e>", "<c-Right>")

	-- Toggle relative line number on/of
	kmn("<leader>rnu", ":set rnu! nu<cr>")

	-- Write(save) file from shortcut
	kmn("<leader>ww", ":w<cr>")
	kmn("<leader>wa", ":wa<cr>")
	kmn("<leader>q", ":q<cr>")
								
	-- Tab from normal mode enters command mode
	kmn("<tab>", ":")

	-- Indent text right after cursor in normal mode
	-- Creates new lines in normal mode
	kmn( "<leader><tab>", "i<tab><esc>l")
	kmn( "<leader><cr>", "o<Esc>k")
	-- Those two only work if your terminal emulator send the signal 
	-- vim expects for that character combination.
	-- https://stackoverflow.com/questions/16359878/how-to-map-shift-enter
	kmn( "<c-cr>", "o<Esc>k")
	kmn( "<s-cr>", "i<tab><esc>l")

	-- Opens Explorer (newtr)
	kmn( "<leader>vp", vim.cmd.Ex)

	-- :noh (no highlight) remap
	kmn( "<leader><space>", ":noh<CR>")

	-- Normal mode Backspace is now @
	kmn("<BS>", "@")

	-- Fast quit without saving
	cmd('command! Q qa!')
		-- this must have the ! after command if you want to :so % this file

	-- Creates some to-do list headers.
	-- This is somewhat important to my workflow.
	kmn("<leader>todo", "o# To-Start<cr># In-progress<cr># Done<esc>2k")

		-- COMMAND MODE EDIT UTILITIES --
	-- From command mode, enters command mode buffer
	kmc("<c- >", "<c-c>q:kf/0")
	kmn("<c- >", "<c-c><c-c>:<up>")
	-- Quick exit command mode buffer
	kmn("<leader>c", "<c-c><c-c>")
	-- leader ; enters command mode edit
	kmn("<leader>;", "q:k")
end

function Remap_split_window_controls() 
	kmn("<c-w>,", "<c-w>7<")
	kmn("<c-w>.", "<c-w>7>")
	kmn("<c-w>=", "<c-w>7+")
	kmn("<c-w>-", "<c-w>7-")
end

-- [[[ Search and replace ]]] --
function Remap_search_and_replace()

	-- NORMAL: serach and replace word under cursor
	kmn("<leader>8", '*:%s//')

	-- VISUAL: search selected text in visual mode
	kmv("<leader>*", 'y<Esc>/<C-r>"<cr>N')

	-- VISUAL: search and replace selected text
	kmv("<leader>8", 'y<Esc>q:i%s/<C-r>"//g<Esc>F/;li')

	-- NORMAL: Counts how many matches for last search
	km('n', "<leader>tc", ":%s///gn<cr>")

	--   VISUAL: Select portion of word under cursor the be kept in the next search and replace
	kmv("<leader>tt", '"tyviwyq:i%s/<c-r>"/<c-r>t/g<Esc>F/;hf/l')

	-- VISUAL: Search for text under register "a" and keeps the selected text. Must copy the search pattern with the "a" register first
	kmv("<leader>ta", '"tyq:i%s/<c-r>a/<c-r>t/g<Esc>F/;hf/l') 
	
	-- Shortcut for search and replace in the whole doc
	km('n',"<leader>/", "q:i%s///g<esc>0f/a")

	-- Shortcut for search and replace within range
	-- Go to normal mode and press ; to go to the "pattern" and "replace"
	km('n',"<leader>,", "q:i.,.+s///g<esc>0f/hhi")

end


-- [[[ Clipboard Utilities ]]] --
function Remap_clipboard_utilities()
	-- Facilitates the use of the system clipboard
	kmn("<leader>yy", '"+yy') 
	kmv("<leader>y", '"+y') 
	kmnv( "<leader>p", '"+p') 
	kmnv( "P", '"+p') 
	
	-- Facilitates the usage of 'a' as an alternative copy-paste register
	kmn("<leader>ayy", '"ayy')
	kmv("<leader>ay", '"ay')
	kmnv("<leader>ap", '"ap')
end



-- [[[ Buffer-related ]]] --
function Remap_default_buffer_manipulation()
	-- Default buffer commands remapings
	kmn( "<leader>n", ":bn<CR>")
	kmn( "<leader>N", ":bN<CR>")
	kmn( "<leader>b", ":buffer ")
	kmn( "<leader>bd", ":bd<CR> ")
	kmn( "<leader>e", ":edit ")
end


-- [[[ LUA and Python scripting utilities ]] --
function Remap_run_scirpt()
	km('n', "<leader><F5>", ":!%:p<cr>")
		-- pr -> Project.Run
end



-- [[[ Remaps for when plugins like sneak.vim are not available ]] --
function Remap_if_plugins_are_not_viable()
	kmn('s','/')
	kmn('S','?')
end



-- [[[ Set Spell Checker ]]] --
function Remap_set_spell() 
	kmn( "<leader>ss", ":set spell!<cr>")
		-- "set  spell" --
	kmn( "<leader>sl", ":set spelllang=")
		-- "set language" --
end



-- [[[ spell checke keys remaps ]]] --
function Remap_spell_check()
	kmn("z;","]s")
	kmn("z,","[s")
	kmn("z<leader>","z=")
end


-->>> Default remaps
Remap_QualityOfLife_base()
Remap_search_and_replace()
Remap_set_spell()
Remap_run_scirpt()
Remap_default_buffer_manipulation()
Remap_clipboard_utilities()
Remap_spell_check()
Remap_split_window_controls()
--Remap_if_plugins_are_not_viable()

