# To-Start
> up:   -priority
> down: +priority

- Try: nvim-ufo
- Try: nvim-treesitter-context

- Fix: f and t not working on remaps
    - jumps to unpredictable locations

- Fix: Lua lsp on nixos
    - more about it (3rd answer): https://stackoverflow.com/questions/75880481/cant-use-lua-lsp-in-neovim
    - perhaps find a way to use system-installed lsp servers together with mason?
    - perhaps switching to the nixos unstable branch might fix it?

- Fix: <leader>Y for "+Y
- Fix: Block_indent()

- Add: oil.nvim remap to add file to the quickfix list
- Feature: Configure Neovim LSP integration without lsp0 (its currently deprecated)

- Feature: Which key
    - add descriptions for every single remap
    - makes it so the plugin only loads if its set to
- feat: rainbow colors: add more distinct colors
- investigate what a linter is:
    - Can it adapt different indentation to what i use in this config?


# In-progress

- feat: add lualine
    - https://github.com/nvim-lualine/lualine.nvim

- Continue experimenting with snacks.nvim


# Done
- refactor: lazy load all possible plugins
- feat: checks for linux install
- snacks.notify: add message title support; create custom notify function
- fix: wilder.nvim python error
- ~Add: better command mode autocomplete~
- Try: snacks.nvim
- Feature: install rainbow
    - https://github.com/luochen1990/rainbow
- Feature: indentation markers
    - Used snacks.nvim for this
- Add: nvim-web-devicons
- Add: keybind: serch across all files with ripgrep using telescope
- Add: trouble.nvim
- Feature: terminal mode clear buffer function
- Fix: htew not working as expected on oil buffers. opening terminals at /tmp

