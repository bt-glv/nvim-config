Terminal = nil

local terminal_emulators = {
    Linux = {
        {
            name              = "Alacritty",
            call              = "alacritty",
            open_at_path      = 'silent! !alacritty --working-directory "%s" & disown',
            open_new_instance = 'silent! !alacritty --working-directory "%s" -e nvim . & disown',
        },
        {
            name              = "Konsole",
            call              = "konsole",
            open_at_path      = 'silent! !konsole --workdir "%s" & disown',
            open_new_instance = 'silent! !konsole --workdir "%s" -e nvim . & disown',
        },
        {
            name              = "Gnome Terminal",
            call              = "gnome-terminal",
            open_at_path      = 'silent! !gnome-terminal --working-directory="%s" & disown',
            open_new_instance = 'silent! !gnome-terminal --working-directory="%s" -- nvim . & disown',
        },
    },
    Windows = {
        {
            call              = "wt",
            open_at_path      = 'silent! !start wt -d "%s" powershell',
            open_new_instance = 'silent! !start wt -d "%s" powershell -NoExit -Command "nvim ."',
        },
        {
            call              = "conhost",
            open_at_path      = 'silent! !start conhost powershell -NoExit -Command "Set-Location \'%s\'"',
            open_new_instance = 'silent! !start conhost powershell -Command "Set-Location \'%s\'; nvim ."',
        },
    },
}

if SystemOS == "Linux" then
    for _, emulator in ipairs(terminal_emulators.Linux) do
        if vim.fn.executable(emulator.call) == 1 then
            Terminal = emulator
            break
        end
    end
elseif SystemOS == "Windows" then
    Terminal = terminal_emulators.Windows[1]
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

