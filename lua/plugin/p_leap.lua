
local function leap()
	require('leap').create_default_mappings()
end

local function error_handler(err)
	if not Show_full_errors then err = "" end
	print("\n\n<<  ERROR  >>\nLeap-> error processing function/config\nMaybe its not installed?\n\n" .. err) end


-- Exec
plugin_add([[
Plug 'ggandor/leap.nvim'
]])

plugin_add_config(function() xpcall(leap, error_handler) end)
