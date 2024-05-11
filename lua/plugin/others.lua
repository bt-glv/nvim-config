
local function main()

	-- Remaps
	cmd([[
	map f <Plug>Sneak_f
	map F <Plug>Sneak_F
	map t <Plug>Sneak_t
	map T <Plug>Sneak_T
	]])

end

local function error_handler(err)
	print("\n\n<<  ERROR  >>\nOther functions -> error processing main function/config\n\n" .. err)
end



-- Exec
plugin_add([[
Plug 'justinmk/vim-sneak'
]])

-- plugin_add_config(function() xpcall(main, error_handler) end)
