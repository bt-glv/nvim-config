# To-Start
- Switch to packer or lazy
- Fix that LUA lsp problem on my nixos installation
    - more about it (3rd answer): https://stackoverflow.com/questions/75880481/cant-use-lua-lsp-in-neovim
    - perhaps find a way to use system-installed lsp servers together with mason?
    - perhaps switching to the nixos unstable branch might fix it?
- Experiment using VimWiki instead of Obsidian
- Install a patched font (nedfonts hack) and that icons plugin

# In-progress
- Copilot:
    - Fix that problem where it enables itself randomly
        - Create a init.lua file just for copilot
        - Find to load copilot lsp last, or to run a command when all lsp server where attached.
    - Install Copilot chat
- Install and try Codium as a copilot alternative
- Install and experiment with undo-tree
- Install and experiment with vim-fugitive and gitsigns.nvim and that other git plugin for managing worktrees

# Done
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

