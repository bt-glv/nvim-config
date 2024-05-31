 
vim.g.netrw_bufsettings='noma nomod nu nobl nowrap ro'
-- Relative line number in netrw
-- This is extremely exoteric and I have no idea how it works..

vim.opt.termguicolors=true
vim.cmd([[
set rnu			"relative line number
set nu			"display line number of line under cursor
set linebreak
set breakindent
set signcolumn=no
set ts=4 sw=4 		"4 space indent
set scrolloff=4
set updatetime=50
]])


