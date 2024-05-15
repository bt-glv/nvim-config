--  << Code Utilities >> --
vim.g.mapleader = " "

-- << Remaps by topic >> --
local function quality_of_life()

	-- Alt+space in all modes is equal to control+c
	km_all("<A- >", "<c-c>")

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
	kmn( "<A-'>", "i<tab><esc>l")
	kmn( "<A-cr>", "o<Esc>k")
	-- <c-cr> and <s-cr> only work if your terminal emulator send the signal 
	-- vim expects for that character combination.
	-- https://stackoverflow.com/questions/16359878/how-to-map-shift-enter

	-- Opens Explorer (newtr)
	kmn( "<leader>pv", vim.cmd.Ex)

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
	kmv("<c- >", ":")

	-- leader ; enters command mode edit
	kmn("<leader>;", "q:k")
end

local function split_window_controls() 
	kmn("<c-w>,", "<c-w>7<")
	kmn("<c-w>.", "<c-w>7>")
	kmn("<c-w>=", "<c-w>7+")
	kmn("<c-w>-", "<c-w>7-")

	kmn("<A-w>", "<c-w>")
	kmn("<A-,>", "<c-w>7<")
	kmn("<A-.>", "<c-w>7>")
	kmn("<A-=>", "<c-w>7+")
	kmn("<A-->", "<c-w>7-")
	kmn("<A-h>", "<c-w>h")
	kmn("<A-j>", "<c-w>j")
	kmn("<A-k>", "<c-w>k")
	kmn("<A-l>", "<c-w>l")
end

-- [[[ Search and replace ]]] --
local function search_and_replace()

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
local function clipboard_utilities()
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
local function default_buffer_manipulation()
	-- Default buffer commands remapings
	kmn( "<leader>n", ":bn<CR>")
	kmn( "<leader>N", ":bN<CR>")
	kmn( "<leader>b", ":buffer ")
	kmn( "<leader>bd", ":bd<CR> ")
	kmn( "<leader>e", ":edit ")
end


-- [[[ LUA and Python scripting utilities ]] --
local function run_scirpt()
	km('n', "<leader><F5>", ":!%:p<cr>")
		-- pr -> Project.Run
end



-- [[[ Remaps for when plugins like sneak.vim are not available ]] --
local function if_plugins_are_not_viable()
	kmn('s','/')
	kmn('S','?')
end



-- [[[ Set Spell Checker ]]] --
local function set_spell() 
	kmn( "<leader>ss", ":set spell!<cr>")
		-- "set  spell" --
	kmn( "<leader>sl", ":set spelllang=")
		-- "set language" --
end



-- [[[ spell checke keys remaps ]]] --
local function spell_check()
	kmn("z;","]s")
	kmn("z,","[s")
	kmn("z<leader>","z=")
end

local function replace_across_project_files()
	kmn("<leader>r1", ':vimgrep /<c-r>"/gj **/*')
	kmv("<leader>r1", 'y:vimgrep /<c-r>"/gj **/*')
	kmn("<leader>r2", ':copen<cr>')
	kmn("<leader>r3", 'q:icfdo %s/<c-r>"/,/g | update<Esc>F,xi')
	-- Be careful where you use this
end


-->>> Default remaps
quality_of_life()
search_and_replace()
set_spell()
run_scirpt()
clipboard_utilities()
spell_check()
split_window_controls()
replace_across_project_files()
--default_buffer_manipulation()
--if_plugins_are_not_viable()

