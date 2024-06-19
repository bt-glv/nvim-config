
local plugins = {}

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

function Lazy_plugin_add(new_plugin)
	table.insert(plugins, new_plugin)
end
function Lazy_plugin_init()
	require("lazy").setup(Plugins)
end


--[[
Optionals
branch = 'stable',
main = 'mini.surround',
opts = { search_method = 'cover_or_next', },
run = function() end,
dependencies = {}

MAIN
local config = {
	'echasnovski/mini.surround',
	lazy = false,
	dependencies = {},
	config = function()
	end -- END Config function 
}
Lazy_plugin_add(config)
]]--
