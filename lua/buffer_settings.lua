 
vim.g.netrw_bufsettings='noma nomod nu nobl nowrap ro'
-- Relative line number in netrw
-- This is extremely exoteric and I have no idea how it works..

vim.cmd([[
set rnu			"relative line number
set nu			"display line number of line under cursor
set linebreak
set breakindent
set signcolumn=no
set ts=4 sw=4 		"sets 4 spaces indent
]])


