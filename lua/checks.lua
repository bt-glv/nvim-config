
---@param text string
local function warning(text)
		vim.notify(text)
end

local function linux_check()
	return vim.loop.os_uname().sysname == "Linux"
	-- return jit.os == "Linux"
end

-- TODO: finish this
---@param warn_func? function
function xclip_wlClipbaord_Check(warn_func)

	local function sh(command)
		local command_obj = io.popen(command)
		if command_obj == nil then error("io.popen is returning nil") end

		local output = command_obj:read('*a')
		output = string.gsub(output,"\n$",'')
		local _,_,op_status = command_obj:close()

		return  {out = output, status = op_status}
	end

	local xclip = sh('which xclip').status
	local wl_clipboard = sh('which wl-paste').status

	if xclip ~= 0 and wl_clipboard ~= 0 then
		warn_func("<<SYSTEM CLIPBOARD NOT WORKING>>\n\nxclip or wl_clipboard NOT currently INSTALLED\n"..xclip..wl_clipboard)
	end

end


-- Code/calls
-- if linux_check() then xclip_wlClipbaord_Check(warning) end

-- local function sh(command)
	-- local command_file = io.popen(command.."")
	-- local output = command_file:read('*a')
	-- local _,_,op_status = command_file:close()

	-- return {out = output, status=op_status}
-- end
--
