
## List buffer variables
:echo keys(b:)


# Nvim Lua functions

## Get project path
local project_path = vim.fn.getcwd()

## Get buffer number
vim.api.nvim_get_current_buf()

## Get buffer name
vim.api.nvim_buf_get_name(bufnr)
vim.api.nvim_buf_get_name(0) -- For current buffer


