
local plugins = "call plug#begin('~/.local/share/nvim/site/plug')"
local plugin_config_methods = {}


function plugin_add_config(config_function) table.insert(plugin_config_methods, config_function) end


function plugin_add(new_plugin)
	plugins = plugins .. "\n".. new_plugin end


function plugin_exec_config()
	if not next(plugin_config_methods) then return end
	for i, func in ipairs(plugin_config_methods) do
		func()
	end
end


function Plugin_init()
	plugin_add("call plug#end()")
	cmd(plugins)
	plugin_exec_config()
end

