# To-Start
> up:   -priority
> down: +priority

- Try: adding another AI helper
    - Codium
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
- Try: snacks.nvim
- Fix: oil sech per file name not working as intended. it should oil cd into that file's folder
- Feature: Configure Neovim LSP integration without lsp0 (its currently deprecated)




# In-progress
- Feature: install raiinbow
    - https://github.com/luochen1990/rainbow
- Feature: indentation markers
    - https://github.com/lukas-reineke/indent-blankline.nvim
    - https://medium.com/@shaikzahid0713/rainbow-parenthesis-and-indentation-in-neovim-dd379f4e516f

# Done
- Add: nvim-web-devicons
- Add: keybind: serch across all files with ripgrep using telescope
- Add: trouble.nvim
- Feature: terminal mode clear buffer function
- Fix: htew not working as expected on oil buffers. opening terminals at /tmp

