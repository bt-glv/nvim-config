--[[
Attention
Any remaps with the Alt modifier key (<A-..>) will not work with windows terminal initially.
To make it work, access the settings, keybinds, and remove every single keybing that uses Alt.

I'm not sure how well those keybinds work with MacOS
]]--

--  << Code Utilities >> --
vim.g.mapleader = " "

-- The command line buffer does not have a name.
-- This is the best way I found to check if the buffer is the command line buffer

-- If its just one line, yy, else, 0Y

-- << Remaps by topic >> --
local function indentation()
	kmn( '<A-;>', "mzo<cr><cr><cr><Esc>'z")
	kmn( "<A-'>", "mzo<cr><Esc>'z")
	kmn( "<A-\\>", "i<tab><esc>l")
	kmn( "<A-cr>", "o<Esc>k")
	kmn( "<leader><tab>", "i<tab><esc>l")
	kmn( "<leader><cr>", "o<Esc>k")
	kmn( "<leader>\\>", "i<tab><esc>l")
	kmn( '<leader>;>', "mzo<cr><cr><cr><Esc>'z")
	kmn( "<leader>'>", "mzo<cr><Esc>'z")

	kmv( "<leader>bi", function() Block_indent() end)
end
local function comments()
	kmnv("<leader>cc",":s$^\\(\\s\\| \\)*\\zs\\(.\\)$\\2$g|noh<Left><Left><Left><Left><Left><Left><Left><Left>")
	kmnv("<leader>cr",':s$^\\(\\s\\| \\)*\\zs$$g|noh<Left><Left><Left><Left><Left><Left><Left>')
	-- wasted 20min of my life for this
	-- TODO: add <leader>cd (commend delete) -> g/^\s*--/normal dd
	-- ^\\(\\s\\)
end
local function surround_basic()
		kmnv("<leader>x", function() Manual_surround() end)
		-- km_all("<leader>xt", function() 
			-- local pp = vim.api.nvim_get_mode().mode 
			-- local esc = Parse_termc("<Esc>")
			-- vim.api.nvim_feedkeys(esc.."i"..pp..esc, "xn", false)
		-- end)
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

	--[[ Old behaviour
	kmi('<c- >', function() Execute_if_command_line_buff(termcodes.cc..termcodes.cc..":<Up>", termcodes.cc..":"..termcodes.up, "i") end)

	kmi('<c- >', function() Execute_if_command_line_buff(Parse_termc("<c-c><c-c>:<Up>"), Parse_termc("<c-c>:<Up>"), "i") end)

	kmc("<c- >", "<c-c>q:k0")

	From command mode, enters command mode buffer
	kmn("<c- >", "<c-c><c-c>:<up>")
	]]--

	vim.keymap.set({"n","c","i"}, "<c- >", function() Cmdline_buff_control() end )
	vim.keymap.set({"n","c"}, "<c-;>", "<c-c><c-c><c-c>q:k")
	kmv("<c- >", ":")

end
local function terminal_mode_related()
	kmt("<C- >","<C-\\><C-n>")
	-- Quickly opens a terminal in a vertical split in a vertical split
	kmn("<leader>ter", "<c-w>v<c-w>l:term<CR><c-w>h") -- opens terminal at project root
	-- kmn("<leader>teh", ':vnew<CR><c-w>l:call termopen(&shell, #{cwd: expand("%:p:h")})<CR><c-w>h') -- Opens terminal at current file location; not usable at this moment
end
local function quality_of_life()


	-- Removes all indentation and spaces at the begining of the line
	kmn("<leader><", [[:s/\v(^[\t ]+)//g|noh<CR>]])
	kmv("<leader><", [[<Esc>:'<,'>s/\v(^[\t ]+)//g|noh<CR>]])

	-- Gets rid of "life with trailing spaces"
	kmn("<leader>rr",[[:%s/\v(^[ \t]+$)|([ \t]+$)//g|noh]])
	kmv("<leader>rr",[[<Esc>:'<,'>s/[ \t]\+$//g|noh]])

	vim.keymap.set({'n','v','i'}	,"<A-BS>", "<Esc>"	) -- Experimental, might delete later
	vim.keymap.set({'n','v','i'}	,"<A- >", "<Esc>"	)
	vim.keymap.set({'c'}			,"<A- >", "<c-c>"	)


	-- Opens terminal emulator and opens neo vim at the current directory
	kmn("<leader>new", ':!alacritty --working-directory "'..vim.fn.getcwd()..'" -e bash -c "nvim ." & disown<cr><cr>')
	-- Opens terminal emulator at project path
	kmn("<leader>tew", ':!alacritty --working-directory "'..vim.fn.getcwd()..'" & disown<cr><cr>')
	-- Opens file explorer (dolphin) at project location
	kmn("<leader>ex", ':!dolphin "'..vim.fn.getcwd()..'" & disown<cr><cr>')


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
	-- kmn("<leader>todo", "o# To-Start<cr># Done<esc>k")
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

	kmn("<leader>yy", '"+yy')
	kmn("<leader>dd", '"+dd')

	kmv("<leader>y", '"+y')
	kmv("<leader>d", '"+d')
	kmnv( "<leader>p", '"+p')
	kmnv( "P", '"+p')
	kmv("Y", '"+y')
	kmv("D", '"+d')

	kmi("<A-P>", '<C-r>"')
	kmi("<A-p>", "<C-r>+")

	-- Facilitates the USAGE of 'a' as an alternative copy-paste register
	-- I rarely use this
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
	-- Be careful with where you use this
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
indentation()
default_buffer_manipulation()
ctrl_space_commands()
tabs()
terminal_mode_related()
comments()
surround_basic()

