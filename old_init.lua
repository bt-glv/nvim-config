-- This file should be named init.lua in ~/.config/nvim
-- Remap function calls at the end of the file


--  << Code Utilities >> --
vim.g.mapleader = " "
function km(mode,trigger,command) vim.keymap.set(mode,trigger,command) end 

function cmd(vim_cmd_command) vim.cmd(vim_cmd_command) end
function kmn(trigger,command) km("n",trigger,command) end
function kmv(trigger,command) km("v",trigger,command) end
function kmnv(trigger,command) km({'n','v'},trigger,command) end
function kmi(trigger,command) km("i",trigger,command) end
function kmc(trigger,command) km("c",trigger,command) end



-- [[[ Quality of life ]]] --
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
	kmn("<leader><tab>", "i<tab><esc>l")
	kmn( "<leader><cr>", "o<Esc>k")
		-- Attention! <cr> (enter) remaps can mess up some terminal mode utilities, like q: command mode buffer editor.

	-- Opens Explorer (newtr)
	kmn( "<leader>pv", vim.cmd.Ex)
		-- pv -> Project.view

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



	-- Relative line number in netrw
	-- This is extremely exoteric and I have no idea how it works..
	vim.g.netrw_bufsettings='noma nomod nu nobl nowrap ro'
	-- This would make an awsome spell cast lmao
	-- noma nomod nu nobl nowrap ro: TESTICULAR TORSION!
	-- noma nomod, nu nobl nowrap ro! THOU NOW HAST A PROLAPSED ANUS!
	
	
	
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
	kmn("<c-w>,", "<c-w>10<")
	kmn("<c-w>.", "<c-w>10>")
	kmn("<c-w>=", "<c-w>10+")
	kmn("<c-w>-", "<c-w>10-")

	kmn("<leader>wv", "<c-w>v")
	kmn("<leader>ws", "<c-w>s")
	kmn("<leader>wh", "<c-w>h")
	kmn("<leader>wj", "<c-w>j")
	kmn("<leader>wk", "<c-w>k")
	kmn("<leader>wl", "<c-w>l")
	kmn("<leader>w,", "<c-w>10<")
	kmn("<leader>w.", "<c-w>10>")
	kmn("<leader>w=", "<c-w>10+")
	kmn("<leader>w-", "<c-w>10-")

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
	kmn( "<leader>bb", ":buffer ")
	kmn( "<leader>bd", ":bd<CR> ")
	kmn( "<leader>e", ":edit ")
end


function Remap_fzf_vim()
	-- fzf.vim remappings
	kmn( "<leader>fzf", 	":Files<CR>") 		-- Fuzzy finds and open file 
	kmn( "<leader>fzb", 	":Buffers<CR>") 	-- Fuzzy finds and open buffer
	kmn( "<leader>fzl", 	":BLines<CR>") 		-- Fuzzy finds a string in your current text buffer
	kmn( "<leader>fzm", 	":Marks<CR>") 		-- Fuzzy finds and open buffer
	kmn( "<leader>fzr", 	":Rg<CR>") 		-- Finds files that contain a ripgrep match
	kmn( "<leader>fzag", 	":Ag<CR>")
end


-- [[[ LUA and Python scripting utilities ]] --
function Remap_run_scirpt()
	km('n', "<leader>pr", ":!%:p<cr>")
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



-- [[ Standard vimrc ]]
function VIM_editor_settings()
cmd([[
set rnu
set nu
set linebreak
set breakindent
]])
end



function Vimplug_plugin_declarations()
cmd([[
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-sneak'



Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'L3MON4D3/LuaSnip'
Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v3.x'}

call plug#end()
]])
end


function lsp_zero_config()
	local lsp_zero = require('lsp-zero')

	lsp_zero.on_attach(function(client, bufnr)
	  -- see :help lsp-zero-keybindings
	  -- to learn the available actions
	  lsp_zero.default_keymaps({buffer = bufnr})
	end)

	--- if you want to know more about lsp-zero and mason.nvim
	--- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
	require('mason').setup({})
	require('mason-lspconfig').setup({
	  handlers = {
	    function(server_name)
	      require('lspconfig')[server_name].setup({})
	    end,
	  },
	})
end 

--[[
::About the plugins::
Treesitter ->
Requires external program: gcc
--]]




--[[
 >>> ABOUT VIM PLUG 

 After installing any new plugin, remember to execute the following command:
 :so %		-> If you are editing this file
 :PlugInstall


 >>>  How to install 

 Link to the repo:
 https://github.com/junegunn/vim-plug

 To install, download the plug.vim file from the repo and place it in the autoload folder.
 # VIM
 `~/.vim/autoload`
 # Neovim
 `~/.local/share/nvim/site/autoload`
 # Neovim (WINDOWS)
 C:\Users\<username>\AppData\Local\nvim\autoload

CURL DOWNLOAD:
curl -O https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
]]--



-- >
-- > Toggles
-- >

-->>> Default vim commands remaps
VIM_editor_settings()
Remap_QualityOfLife_base()
Remap_search_and_replace()
Remap_set_spell()
Remap_run_scirpt()
Remap_default_buffer_manipulation()
Remap_clipboard_utilities()
Remap_spell_check()
Remap_split_window_controls()


-->>> Vim plug plguing declaration
Vimplug_plugin_declarations()


-->>> LSP ZERO base config Disable/Enable
lsp_zero_config()


-->>> External programs and/or plugin dependant
Remap_fzf_vim() -- Requires ripgrep and "ag" to be installed outside neovim




-->>> Enable to use "gambiarras" to emulate/mitigate the lack of certain extentions
--Remap_if_plugins_are_not_viable()

