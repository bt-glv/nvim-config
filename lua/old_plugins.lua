
vim.cmd([[
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

--[[
--
# Required External programs
gcc | clang
ripgrep


# The basics
Install declared plugins
 :so %		-> If you are editing this file
 :PlugInstall

 Uninstalling plugins
 -- Remove the plugin(s) from your Plug call
 :PlugClean



# How to install PLUG

Link to the repo:
https://github.com/junegunn/vim-plug
curl -O https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

 To install, download the plug.vim file from the repo and place it in the autoload folder.

 ## Neovim
cd ~/.local/share/nvim/site/autoload
curl -O https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

 ## VIM
cd ~/.vim/autoload
curl -O https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

 ## Neovim (WINDOWS)
 C:\Users\<username>\AppData\Local\nvim\autoload
 -- Place the file on this folder

]]--





