
local version_check = function()
	local vim_versoin = vim.version()
	local compatible  = (vim.version.cmp(vim.version(), {0,12,0}) >= 0 )

	if(not compatible) then

		local message = "\n\n" ..
						"Expected Neovim Version: 	12\n" ..
						"What you got:				%d\n"

		Notify(
				string.format(message, vim_versoin.minor), 4,
				{title = "Incompatible Neovim Version"}
		)

	end
end
local operating_system = {
	Linux = {

		version   = version_check,
		clipboard = function()

			local xclip_found        = vim.fn.executable("xclip")    == 1
			local wl_clipboard_found = vim.fn.executable("wl-paste") == 1

			if (not xclip_found) and (not wl_clipboard_found) then

				Notify(
					string.format(
						"\nxclip:        %s\nwl-clipboard: %s\n\nCurrent Display Server: %s",
						tostring(xclip_found),
						tostring(wl_clipboard_found),
						vim.env.XDG_SESSION_TYPE
					), 4,
					{title='Clipboard Utility Not Found'}
				)

			end
		end,
		dependencies = function()
			local deps = {
				'gcc',
				'node',
				'npm',
				'fd',
				'tree-sitter',
				'rg',
				'wget',
				'unzip',
			}

			local error_message      = "\n"
			local show_error_message = false

			for _, dep in ipairs(deps) do

				local exists = (vim.fn.executable(dep)==1)
				if(not exists) then
					show_error_message = true
					error_message = error_message .. dep .. "\n"
				end

			end

			if(show_error_message) then
				Notify(error_message, 4, {title="Missing Dependencies"})
			end

		end
	},

	Windows_NT = {
		version = version_check,
        clipboard = function()
            -- vim.fn.system('where win32yank')
            -- local win32yank_found = (vim.v.shell_error == 0)
            local win32yank_found = vim.fn.executable("win32yank") == 1

            if (not win32yank_found) then
                Notify(
                    string.format(
                        "\nwin32yank: %s\n",
                        tostring(win32yank_found)
                    ), 4,
                    {title='Clipboard Utility Not Found'}
                )
            end
        end,
        dependencies = function()
            local deps = {
                'cl',
                'node',
                'npm',
                'fd',
                'tree-sitter',
                'rg',
                'wget',
                'unzip',
            }

            local error_message      = "\n"
            local show_error_message = false

            for _, dep in ipairs(deps) do

                local exists = vim.fn.executable(dep) == 1 
                if(not exists) then
                    show_error_message = true
                    error_message = error_message .. dep .. "\n"
                end
            end

            if(show_error_message) then
                Notify(error_message, 4, {title="Missing Dependencies"})
            end

        end
    },
}
operating_system.Windows = operating_system.Windows_NT;

if(not No_Dependency_Checks) then

	local checks = operating_system[vim.loop.os_uname().sysname]
	if (checks ~= nil) then
		for _, func in pairs(checks) do func() end
	end

end


