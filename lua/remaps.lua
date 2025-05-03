--[[
Attention
Any remaps with the Alt modifier key (<A-..>) will not work with windows terminal initially.
To make it work, access the settings, keybinds, and remove every single keybing that uses Alt.

I'm not sure how well those keybinds work with MacOS
]]--

--  << Code Utilities >> --
vim.g.mapleader = " "


-- << Remaps by topic >> --
local function indentation()
	km("n", '<A-;>', "mzo<cr><cr><cr><Esc>'z")
	km("n", "<A-'>", "mzo<cr><Esc>'z")
	km("n", "<A-\\>", "i<tab><esc>l")
	km("n", "<A-cr>", "o<Esc>k")
	-- km("n", "<leader><tab>", "i<tab><esc>l")
	-- km("n", "<leader><cr>", "o<Esc>k")
	-- km("n", "<leader>\\>", "i<tab><esc>l")
	-- km("n", '<leader>;>', "mzo<cr><cr><cr><Esc>'z")
	-- km("n", "<leader>'>", "mzo<cr><Esc>'z")

	km("v", "<leader>bi", function() Block_indent() end)
end
local function comments()
	km({"v","n"},"<leader>cc",":s$^\\(\\s\\| \\)*\\zs\\(.\\)$\\2$g|noh<Left><Left><Left><Left><Left><Left><Left><Left>")
	km({"v","n"},"<leader>cr",':s$^\\(\\s\\| \\)*\\zs$$g|noh<Left><Left><Left><Left><Left><Left><Left>')
	-- wasted 20min of my life for this
end
local function surround_basic()
		km({"v","n"},"<leader>x", function() Manual_surround() end)
		-- km_all("<leader>xt", function()
			-- local pp = vim.api.nvim_get_mode().mode
			-- local esc = Parse_termc("<Esc>")
			-- vim.api.nvim_feedkeys(esc.."i"..pp..esc, "xn", false)
		-- end)
end
local function tabs()

	km("n","<leader><Right>",	":tabnext<CR>")
	km("n","<leader><Left>", 	":tabprevious<CR>")

	km("n","<leader>tan", ":tabnew<CR>")
	km("n","<leader>tad", ":tabclose<CR>")
	km("n","<leader>1", "1gt")
	km("n","<leader>2", "2gt")
	km("n","<leader>3", "3gt")
	km("n","<leader>4", "4gt")
	km("n","<leader>5", "5gt")
	km("n","<leader>6", "5gt")
	km("n","<leader>7", "7gt")
	km("n","<leader>8", "8gt")
	km("n","<leader>9", "9gt")

end
local function movement()
	km("v", "J", ":m '>+1<CR>gv=gv")
	km("v", "K", ":m '<-2<CR>gv=gv")

	km("n","J", "mzJ`z")
	km("n","<C-d>", "<C-d>zz")
	km("n","<C-u>", "<C-u>zz")
	km("n","<C-o>", "<C-o>zz")
end
local function ctrl_space_commands()

	km({"n","c","i"}, "<c- >", function() Cmdline_buff_control() end )
	km({"n","c"}, "<c-;>", "<c-c><c-c><c-c>q:k")
	km("v","<c- >", ":")

end
local function terminal_mode_related()
	km("t","<C- >","<C-\\><C-n>")

	-- Quickly opens a terminal in a vertical split in a vertical split
	km("n","<leader>ter", "<c-w>v<c-w>l:term<CR><c-w>h") -- opens terminal at project root

	-- km("n","<leader>teh", ':vnew<CR><c-w>l:call termopen(&shell, #{cwd: expand("%:p:h")})<CR><c-w>h') -- Opens terminal at current file location; not usable at this moment
end
local function quality_of_life()

	-- restart all lsp servers
	km("n", "<leader>lr", function() RestartLspServers() end)

	-- This substitutes a vim feature that shows the hex to the character under the cursor
	km({'v','n'},'ga','<Esc>ggVG')

	-- Removes all indentation and spaces at the begining of the line
	km("n","<leader><", [[:s/\v(^[\t ]+)//g|noh<CR>]])
	km("v","<leader><", [[<Esc>:'<,'>s/\v(^[\t ]+)//g|noh<CR>]])

	-- Gets rid of "life with trailing spaces"
	km("n","<leader>rr",[[:%s/\v(^[ \t]+$)|([ \t]+$)//g|noh]])
	km("v","<leader>rr",[[<Esc>:'<,'>s/[ \t]\+$//g|noh]])

	km({'n','v','i'}	,"<A-BS>", "<Esc>"	) -- Experimental, might delete later

	-- By using nvim_feedkeys on "t" mode, <A- > now works with every single plugin,
	-- since the keys are sent as if typed.
	km({'n','v','i'}	,"<A- >", function() vim.api.nvim_feedkeys("", "t", false) end)
	km({'c'}			,"<A- >", function() vim.api.nvim_feedkeys("", "t", false) end)

	-- Opens terminal emulator and opens neo vim at the current directory
	km("n","<leader>new", ':!alacritty --working-directory "'..vim.fn.getcwd()..'" -e bash -c "nvim ." & disown<cr><cr>')
	-- Opens terminal emulator at project path
	km("n","<leader>tew", ':!alacritty --working-directory "'..vim.fn.getcwd()..'" & disown<cr><cr>')
	-- Opens file explorer (dolphin) at project location
	km("n","<leader>ex", ':!dolphin "'..vim.fn.getcwd()..'" & disown<cr><cr>')

	vim.keymap.set("n","<leader>hex", function()
			local path = vim.fn.expand('%:p:h')
			path = vim.fn.substitute(path, "^oil:[/][/]","","g")
			vim.cmd('silent! !dolphin "'..path..'" & disown')
			-- for debuggin purposes
			-- local to_print = "i"..path
			-- vim.api.nvim_feedkeys(to_print, "xn", false)
		end)

	vim.keymap.set("n","<leader>htew", function()
			local path = vim.fn.expand('%:p:h')
			path = vim.fn.substitute(path, "^oil:[/][/]","","g")
			vim.cmd('silent! !alacritty --working-directory "'..path..'" & disown')
		end)

	km("n","<leader>mk", ":mksession!<cr>")
	km("n","<leader>bash", ":w !bash")

	km("v",":", ":<C-u>")

	-- zz zt zb in visual selection mode
	km("v","zt", "<Esc>ztgv")
	km("v","zz", "<Esc>zzgv")
	km("v","zb", "<Esc>zbgv")

	-- control+hjkl as arrow keys in command mode
	km("c","<c-h>", "<Left>")
	km("c","<c-j>", "<Down>")
	km("c","<c-k>", "<Up>")
	km("c","<c-l>", "<Right>")
	km("c","<c-b>", "<c-Left>")
	km("c","<c-e>", "<c-Right>")

	-- Toggle relative line number on/of
	km("n","<leader>rnu", ":set rnu! nu<cr>")

	-- Write(save) file from shortcut
	km("n","<leader>ww", ":w<cr>")
	km("n","<leader>wa", ":wa<cr>")
	km("n","<leader>q", ":q<cr>")

	-- Opens Explorer (newtr)
	km("n", "<leader>pv", vim.cmd.Ex)

	-- :noh (no highlight) remap
	km("n", "<leader><space>", ":noh<CR>")

	-- Normal mode Backspace is now @
	km("n","<BS>", "@")

	-- quit without saving
	-- if oil is active, it will quit at file path
	vim.api.nvim_create_user_command( 'QA', function() vim.cmd('qa!') end, {})
	vim.api.nvim_create_user_command( 'QQ', function() Exit_to_file_path() end, {})
end
local function split_window_controls()

	km("n","<c-w>,", "<c-w>7<")
	km("n","<c-w>.", "<c-w>7>")
	km("n","<c-w>=", "<c-w>7+")
	km("n","<c-w>-", "<c-w>7-")

	km("n","<M-w>", "<c-w>")
	km("n","<M-,>", "<c-w>7<")
	km("n","<M-.>", "<c-w>7>")
	km("n","<M-=>", "<c-w>7+")
	km("n","<M-->", "<c-w>7-")

	km("n","<M-h>", function() vim.cmd.wincmd('h') end)
	km("n","<M-j>", function() vim.cmd.wincmd('j') end)
	km("n","<M-k>", function() vim.cmd.wincmd('k') end)
	km("n","<M-l>", function() vim.cmd.wincmd('l') end)

	-- km("n","<c-h>", function() vim.cmd.wincmd('h') end)
	-- km("n","<c-j>", function() vim.cmd.wincmd('j') end)
	-- km("n","<c-k>", function() vim.cmd.wincmd('k') end)
	-- km("n","<c-l>", function() vim.cmd.wincmd('l') end)
	--
	-- km("n","<c-,>", "<c-w>7<")
	-- km("n","<c-.>", "<c-w>7>")
	-- km("n","<c-=>", "<c-w>7+")
	-- km("n","<c-->", "<c-w>7-")
end
local function search_and_replace()
	-- NORMAL: serach and replace word under cursor
	km("n","<leader>*", [[viwy<Esc>q:i%s/<C-r>"/]]) -- TODO: Fix this
	-- VISUAL: search selected text in visual mode
	km("v","<leader>8", 'y<Esc>/<C-r>"/e<cr>')
	-- VISUAL: search and replace selected text
	km("v","<leader>*", 'y<Esc>q:i%s/\\(<C-r>"\\)//g<Esc>F/;li')
	-- NORMAL: Counts how many matches for last search
	km('n', "<leader>tc", ":%s///gn<cr>")
end

local function upper_to_unnamed_buffer(keys)
	vim.api.nvim_feedkeys(keys, "xn", false)
	vim.fn.setreg("+", vim.fn.getreg(""))
end

local function clipboard_utilities()
	-- Facilitates the use of the system clipboard
	--
	km("v","<leader>y", '"+y')
	km("v","<leader>d", '"+d')
	km({"v","n"}, "<leader>p", '"+p')
	km({"v","n"}, "P", '"+p')
	km("v","Y", '"+y')
	km("v","D", '"+d')

	km("n","<leader>yy", '"+yy')
	km("n","<leader>dd", '"+dd')



	-- km("n", "<leader>Y", function() upper_to_unnamed_buffer("Y") end )
	-- km("n", "<leader>D", function() upper_to_unnamed_buffer("D") end )
	-- km("n", "<leader>C", function() upper_to_unnamed_buffer("C") end )

	km("n", "<leader>Y", [[v$"+y]])

	-- km("n", "<leader>Y", [["+Y]])
	-- km("n", "<leader>D", [["+D]])
	-- km("n", "<leader>C", [["+C]])


	km("i","<A-P>", '<C-r>"')
	km("i","<A-p>", "<C-r>+")

	-- Facilitates the USAGE of 'a' as an alternative copy-paste register
	-- I rarely use this
	km("n","<leader>ayy", '"ayy')
	km("n","<leader>add", '"add')
	km("v","<leader>ay", '"ay')
	km("v","<leader>ad", '"ad')
	km({"v","n"},"<leader>ap", '"ap')
end
local function default_buffer_manipulation()
	-- Default buffer commands remapings
	km("n", "<A-n>", ":bn<CR>")
	km("n", "<A-N>", ":bN<CR>")
	km("n", "<leader>bd", ":bd!<CR>")
end
local function run_scirpt()
		--  LUA and Python scripting utilities  --
	km('n', "<leader><F5>", ":!%:p<cr>")
		-- pr -> Project.Run
end
local function set_spell()
--  Set Spell Checker  --
	km("n", "<leader>ss", ":set spell!<cr>")
		-- "set  spell" --
	km("n", "<leader>sl", ":set spelllang=")
		-- "set language" --
end
local function spell_check()
--  spell checke keys remaps  --
	km("n","z;","]s")
	km("n","z,","[s")
	km("n","z<leader>","z=")
end
local function replace_across_project_files()
	km("n","<leader>r1", ':vimgrep /<c-r>"/gj **/*')
	km("v","<leader>r1", 'y:vimgrep /<c-r>"/gj **/*')
	km("n","<leader>r2", ':copen<cr>')
	km("n","<leader>r3", 'q:icfdo %s/<c-r>"/,/g | update<Esc>F,xi')
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

