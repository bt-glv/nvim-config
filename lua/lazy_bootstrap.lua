
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)



--[[
Optionals
branch = 'stable',
main = 'mini.surround',
opts = { search_method = 'cover_or_next', },
run = function() end,
dependencies = {}

MAIN
return {
	'echasnovski/mini.surround',
	lazy = false,
	dependencies = {},
	config = function()
	end -- END Config function 
}
]]--
