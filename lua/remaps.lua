
--[[
Attention
All remaps with Alt "<A-...>" do not work as intended on windows terminal
and MacOs terminal. Not use if this is a thing only on their respective 
operating system of if it is just the terminal emulators.
]]--
--  << Code Utilities >> --
vim.g.mapleader = " "
function Execute_if_command_line_buff(_if,_else,mode)
	local buf_name = vim.api.nvim_buf_get_name(0) 
	-- This command always get the current active buffer name
	if buf_name:match("Command Line") then
		vim.api.nvim_feedkeys(_if, mode, false)
		-- This send keys to be executed in the active buffer. 
		-- Just like if it where a remap.
		return
	end
		vim.api.nvim_feedkeys(_else, mode, false)
		return
end


-- << Remaps by topic >> --
local function movement()
	vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
	vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

	kmn("J", "mzJ`z")
	kmn("<C-d>", "<C-d>zz")
	kmn("<C-u>", "<C-u>zz")
	kmn("<C-o>", "<C-o>zz")
end
local function ctrl_space_commands()

	kmi('<c- >', '<cmd>lua Execute_if_command_line_buff("<c-c><c-c>:<Up>","<c-r>", "i")<cr>')
	kmc("<c- >", "<c-c>q:k0")

	-- From command mode, enters command mode buffer
	kmn("<c- >", "<c-c><c-c>:<up>")
	kmv("<c- >", ":")
end
local function quality_of_life()

	-- zz zt zb in visual selection mode
	kmv("zt", "<Esc>ztgv")
	kmv("zz", "<Esc>zzgv")
	kmv("zb", "<Esc>zbgv")

	kmn("<leader>mk", ":mksession!<cr>")
	kmn("<leader>bash", ":w !bash")

	-- Alt+space in all modes is equal to control+c
	km_all("<A- >", "<Esc>")

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
local function search_and_replace()
	-- NORMAL: serach and replace word under cursor
	kmn("<leader>8", 'yiw:%s/\\(<C-r><cr>"\\)/') -- TODO: Fix this
	-- VISUAL: search selected text in visual mode
	kmv("<leader>*", 'y<Esc>/<C-r>"/e<cr>')
	-- VISUAL: search and replace selected text
	kmv("<leader>8", 'y<Esc>q:i%s/\\(<C-r>"\\)//g<Esc>F/;li')
	-- NORMAL: Counts how many matches for last search
	km('n', "<leader>tc", ":%s///gn<cr>")

	kmn("<leader>/", "//e<Left><Left>")
	kmn("<leader>?", "??e<Left><Left>")
end
local function outdated_stuff()
	-- I seldom use those shortcuts anymore
	-- After I discovered that i can do a serach and replace only in the visual mode selected text, this became obsolete
	--
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
local function clipboard_utilities()
	-- Facilitates the use of the system clipboard
	kmi("<A-p>", '<C-r>"')
	kmi("<A-P>", "<C-r>+")
	kmn("<leader>yy", '"+yy')
	kmn("<leader>dd", '"+dd')
	kmv("<leader>y", '"+y')
	kmv("<leader>d", '"+d')
	kmnv( "<leader>p", '"+p')
	kmnv( "P", '"+p')
	-- Facilitates the usage of 'a' as an alternative copy-paste register
	kmn("<leader>ayy", '"ayy')
	kmn("<leader>add", '"add')
	kmv("<leader>ay", '"ay')
	kmv("<leader>ad", '"ad')
	kmnv("<leader>ap", '"ap')
end
local function default_buffer_manipulation()
	-- Default buffer commands remapings
	kmn( "<A-n>", ":bn<CR>")
	kmn( "<A-N>", ":bN<CR>")
end
local function run_scirpt()
		--  LUA and Python scripting utilities  --
	km('n', "<leader><F5>", ":!%:p<cr>")
		-- pr -> Project.Run
end
local function set_spell() 
--  Set Spell Checker  --
	kmn( "<leader>ss", ":set spell!<cr>")
		-- "set  spell" --
	kmn( "<leader>sl", ":set spelllang=")
		-- "set language" --
end
local function spell_check()
--  spell checke keys remaps  --
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
local function indentation_bs()
	kmn( '<A-;>', "mzo<cr><cr><cr><Esc>'z")
	kmn( "<A-'>", "mzo<cr><Esc>'z")
	kmn( "<A-\\>", "i<tab><esc>l")
	kmn( "<A-cr>", "o<Esc>k")
	kmn( "<leader><tab>", "i<tab><esc>l")
	kmn( "<leader><cr>", "o<Esc>k")
	kmn( "<leader>\\>", "i<tab><esc>l")
	kmn( '<leader>;>', "mzo<cr><cr><cr><Esc>'z")
	kmn( "<leader>'>", "mzo<cr><Esc>'z")
end



-->>> Declare remaps to use here <<<--
quality_of_life()
search_and_replace()
set_spell()
run_scirpt()
clipboard_utilities()
spell_check()
split_window_controls()
replace_across_project_files()
movement()
indentation_bs()
-- outdated_stuff()
default_buffer_manipulation()
ctrl_space_commands()
