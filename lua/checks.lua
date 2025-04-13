
---@param text string
function Warning_print_func(text)
		local timer = vim.loop.new_timer()
		timer:start(3000,0,function() print(text) end)
end

local function linux_check()
	return vim.loop.os_uname().sysname == "Linux"
	-- return jit.os == "Linux"
end

---@param warn_func? function
function xclip_wlClipbaord_Check(warn_func)
	if type(warn_func) ~= "function" then error("Warning function not defined in xclip_wlClipbaord_Check") end

	local function shell(command)
		local handle = io.popen(command)
		return handle:read("*a")
	end

	local xclip = shell("which xclip >/dev/null 2>&1;echo $?") ~= "0\n"
	local wl_clipboard = shell("which wl-paste >/dev/null 2>&1;echo $?") ~= "0\n"

	if xclip and wl_clipboard then
		warn_func("<<SYSTEM CLIPBOARD NOT WORKING>>\n\nxclip wl_clipboard NOT INSTALLED.\n\n")
	end

end


-- Code/calls
if linux_check() then xclip_wlClipbaord_Check(Warning_print_func) end

