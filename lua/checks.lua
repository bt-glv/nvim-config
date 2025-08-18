
local warn_func = Notify
local _os = {
	Linux = {
		clipboard = function()
			vim.fn.system('which xclip')
			local xclip = vim.v.shell_error

			vim.fn.system('which wl-paste')
			local wl_clipboard = vim.v.shell_error

			if xclip ~= 0 and wl_clipboard ~= 0 then
				warn_func("xclip or wl_clipboard NOT INSTALLED\n"..xclip..wl_clipboard, 4,{title='SYSTEM CLIPBOARD NOT WORKING'})
			end
		end,
		dependencies = function()
			local function check(program, err_message)
				if not err_message then err_message = program..' not installed' end
				if type(program) == 'table' then
					for _, program_name in ipairs(program) do
						check(program_name, err_message)
					end
				end
				vim.fn.system(program)
				if vim.v.shell_error ~= 0 then warn_func(err_message,4, {title='Dependency'}) end
			end
			check({
				'gcc',
				'node',
				'npm',
				'fd',
			})
		end
	}
}

local checks = _os[vim.loop.os_uname().sysname]
if checks ~= nil then
	for _, func in ipairs(checks) do func() end
end

