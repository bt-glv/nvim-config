# To-Start
- Fix that LUA lsp problem on my nixos installation
    - more about it (3rd answer): https://stackoverflow.com/questions/75880481/cant-use-lua-lsp-in-neovim
    - perhaps find a way to use system-installed lsp servers together with mason?
    - perhaps switching to the nixos unstable branch might fix it?
- Experiment using VimWiki instead of Obsidian
- Install a patched font (nedfonts hack) and that icons plugin
- CopilotChat:
    - Execute remaps just on copilot chat buffer
- Install and try Codium as a copilot alternative
- Consider removing flash.nvim and adding another plugin that just handles multiline "f" and "t"
- Create a utility that checks if there is any terminal buffer open and displays it somewhere 
- Create a utility that enables remaps just for terminal buffers, somehow
- Try out some fold plugins: nvim-ufo, nvim-treesitter-context, et cetera

# In-progress
- Git
    X Install and test gitsigns
    d Install and test neogit
    d Install and test diffview.nvim
    - Install and test vim-fugitive
    - Configure gitsings 
        - Remaps
        - Fix that lsp sign column (remove it)

# Done
- Fix all command mode buffer specific remaps
- Fix those other pending remaps 
- Treesitter as a fold source
- Try switching to telescope
    - try the register selection feature
- Terminal mode remaps
- Add remaps for tab management
- Add tabby.nvim just to rename tabs
- Install and experiment with wilder.nvim
- Install and experiment with undo-tree
- Switch to lazy.nvim
- Copilot:
    - Fix that problem where it enables itself randomly
        - Create a init.lua file just for copilot
        - Find a way to load copilot lsp last, or to run a command when all lsp server where attached.
    - Install Copilot chat
- Fix that issue with surround.vim on visual line mode
    - Surround.vim S is not unmapped in visual line mode. The expected behaviour is that S should be a backwards search with leap.
- Install and try Harpoon
- Enable copilot automatically if a lsp is active for the current buffer. Do this by either creating a autocmd or hooking a function to a lsp-config event.
- Try FireNvim 
- Get github copilot working
- Install flash
- Install leap
- Try and configure surround.vim
- Alt + space for esc... maybe?
- Try nvim tree
- Try oil.vim
- Get lsp working
- Fix my colorscheme
- Find a better remap for <c-w>
- Change 8 space indenting to 4 or 3 space indenting 




# Temp test

top right corner => shows the name of the buffers in each window

default state ->
Shows the name i defined: 'changed'; at the top right corner when the tab bar shows up.
I defined it on:

            line 49
			{ 'changed', hl = theme.fill },
			hl = theme.fill,

Copilot result ->
shows tabs all times 
Tab names remain the same after creation: "[no name]"
At the top right corner it shows the name I told it to use "Changed"
in another segment:

            line 49
			{ 'changed', hl = theme.fill },
			hl = theme.fill,



