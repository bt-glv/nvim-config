
Terminal = nil;
local terminal_emulators = {
    Linux = {
        alacritty = {
            call              = "alacritty",
            open_at_path      = 'silent! !alacritty --working-directory "%s" & disown',
            open_new_instance = 'silent! !alacritty --working-directory "%s" -e nvim . & disown',
        },
        konsole = {
            call              = "konsole",
            open_at_path      = 'silent! !konsole --workdir "%s" & disown',
            open_new_instance = 'silent! !konsole --workdir "%s" -e nvim . & disown',
        },
        gnome_terminal = {
            call              = "gnome-terminal",
            open_at_path      = 'silent! !gnome-terminal --working-directory="%s" & disown',
            open_new_instance = 'silent! !gnome-terminal --working-directory="%s" -- nvim . & disown',
        }
    },
    Windows = {
        windows_terminal = {
            call              = "wt",
            open_at_path      = 'silent! !start wt -d "%s" powershell',
            open_new_instance = 'silent! !start wt -d "%s" powershell -NoExit -Command "nvim ."',
        },
        conhost = { -- legacy terminal window
            call              = "conhost",
            open_at_path      = 'silent! !start conhost powershell -NoExit -Command "Set-Location \'%s\'"',
            open_new_instance = 'silent! !start conhost powershell -Command "Set-Location \'%s\'; nvim ."',
        }
    },
}

if SystemOS == "Linux" then

	for _, terminal_emulator in pairs(terminal_emulators.Linux) do
		vim.fn.system('which '..terminal_emulator.call)
		local is_present = (vim.v.shell_error == 0)

		if is_present then
			Terminal = terminal_emulator
			break
		end

	end

elseif SystemOS == "Windows" then
	Terminal = terminal_emulators.Windows.windows_terminal
end


OpenTerminal = function(path)
	if Terminal == nil then
		Notify("\nNo terminal emulator set", 1, {title = "New Instance Error"})
	end

	vim.cmd( string.format(Terminal.open_at_path, path))
end
OpenNeovim = function(path)
	if Terminal == nil then
		Notify("\nNo terminal emulator set", 1, {title = "New Instance Error"})
	end

	vim.cmd( string.format(Terminal.open_new_instance, path))
end

