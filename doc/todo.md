# To-Start
- Fix that LUA lsp problem on my nixos installation
    - more about it (3rd answer): https://stackoverflow.com/questions/75880481/cant-use-lua-lsp-in-neovim
    - perhaps find a way to use system-installed lsp servers together with mason?
    - perhaps switching to the nixos unstable branch might fix it?
- Install and try Codium as a copilot alternative
- Create a utility that checks if there is any terminal buffer open and displays it somewhere 
- Try out some fold plugins: nvim-ufo, nvim-treesitter-context, et cetera
- ??? Vim regex formatter
    - Create a remap that format any regex simbles inside seleciton 

# In-progress

# Done
- Git
    X Install and test gitsigns
    x Install and test neogit
    x Install and test diffview.nvim
    x Install and test vim-fugitive
    x Configure gitsings 
        x Remaps
        x Fix that lsp sign column (remove it)
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




