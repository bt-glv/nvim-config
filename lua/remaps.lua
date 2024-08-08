--[[
Attention
All remaps with Alt "<A-...>" do not work as intended on windows terminal
and MacOs terminal. Not sure if this is a thing only on their respective 
operating system of if it is just the terminal emulators.
]]--
--  << Code Utilities >> --
vim.g.mapleader = " "
function Parse_termcodes(key) return vim.api.nvim_replace_termcodes(key, true, false, true) end

-- The command line buffer does not have a name.
-- This is the best way I found to check if the buffer is the command line buffer
function Execute_if_command_line_buff(if_exec,else_exec,mode)
	local bufnr 	= vim.api.nvim_get_current_buf()
	local filetype 	= vim.bo[bufnr].filetype
	local bufname	= vim.api.nvim_buf_get_name(bufnr)
	local success, undo_ftplugin = pcall(function() return vim.api.nvim_buf_get_var(bufnr, "undo_ftplugin") end)
	if not success then undo_ftplugin = "" end

	if filetype == "vim" and (bufname == "" or bufname == nil) and undo_ftplugin == "call VimFtpluginUndo()" then
		vim.api.nvim_feedkeys(if_exec, mode, false)
		return
	end

	vim.api.nvim_feedkeys(else_exec, mode, false)
end

function Execute_if_buff(buffer_name,if_exec,else_exec,mode)
	local buf_name = vim.api.nvim_buf_get_name(0) 
	if buf_name:match(buffer_name) then
		vim.api.nvim_feedkeys(if_exec, mode, false)
		return
	end
		if else_exec == nil or else_exec == "" then return end 
		vim.api.nvim_feedkeys(else_exec, mode, false)
end

-- << Remaps by topic >> --
local function terminal_mode()
	kmt("<C- >","<C-\\><C-n>")
end

local function tabs()

	kmn("<leader>tl", ":tabnext<CR>")
	kmn("<leader>th", ":tabprevious<CR>")
	kmn("<leader>tn", ":tabnew<CR>")
	kmn("<leader>td", ":tabclose<CR>")
	kmn("<leader>t1", "1gt")
	kmn("<leader>t2", "2gt")
	kmn("<leader>t3", "3gt")
	kmn("<leader>t4", "4gt")
	kmn("<leader>t5", "5gt")

end
local function movement()
	vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
	vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

	kmn("J", "mzJ`z")
	kmn("<C-d>", "<C-d>zz")
	kmn("<C-u>", "<C-u>zz")
	kmn("<C-o>", "<C-o>zz")
end
local function ctrl_space_commands()

	-- kmi('<c- >', function() Execute_if_command_line_buff(termcodes.cc..termcodes.cc..":<Up>", termcodes.cc..":"..termcodes.up, "i") end)
	kmi('<c- >', function() Execute_if_command_line_buff(Parse_termcodes("<c-c><c-c>:<Up>"), Parse_termcodes("<c-c>:<Up>"), "i") end)
	kmc("<c- >", "<c-c>q:k0")

	-- From command mode, enters command mode buffer
	kmn("<c- >", "<c-c><c-c>:<up>")
	kmv("<c- >", ":")
end
local function quality_of_life()

	vim.keymap.set({'n','v','i'}	,"<A- >", "<Esc>")
	vim.keymap.set({'c'}			,"<A- >", "<c-c>")

	-- Opens alacritty terminal emulator and opens vim at the current directory
	kmn("<leader>new", ':!alacritty --working-directory '..vim.fn.getcwd()..' -e bash -c "nvim ." &<cr><cr>')

	kmn("<leader>mk", ":mksession!<cr>")
	kmn("<leader>bash", ":w !bash")

	kmv(":", ":<C-u>")

	-- zz zt zb in visual selection mode
	kmv("zt", "<Esc>ztgv")
	kmv("zz", "<Esc>zzgv")
	kmv("zb", "<Esc>zbgv")

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
	kmn("<leader>todo", "o# To-Start<cr># Done<esc>k")
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
	kmn("<leader>*", [[viwy<Esc>q:i%s/<C-r>"/]]) -- TODO: Fix this
	-- VISUAL: search selected text in visual mode
	kmv("<leader>8", 'y<Esc>/<C-r>"/e<cr>')
	-- VISUAL: search and replace selected text
	kmv("<leader>*", 'y<Esc>q:i%s/\\(<C-r>"\\)//g<Esc>F/;li')
	-- NORMAL: Counts how many matches for last search
	km('n', "<leader>tc", ":%s///gn<cr>")
end
local function clipboard_utilities()
	-- Facilitates the use of the system clipboard
	kmi("<A-p>", '<C-r>')
	kmi("<A-P>", "<C-r>+")
	kmn("<leader>yy", '"+yy')
	kmn("<leader>dd", '"+dd')
	kmv("<leader>y", '"+y')
	kmv("<leader>d", '"+d')
	kmnv( "<leader>p", '"+p')
	kmnv( "P", '"+p')

	kmn("<leader>Y", '"+Y')
	kmn("<leader>D", '"+D')
	kmn("<leader>C", '"+C')

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
	kmn( "<leader>bd", ":bd!<CR>")
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
default_buffer_manipulation()
ctrl_space_commands()
tabs()
terminal_mode()
