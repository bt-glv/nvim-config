# To-Start

- Fix: <leader>Y for "+Y

- Feature: Which key
- Feature: QQ on terminal mode cds to that terminal's path.

- Experiment: Replace cmp.nvim with blink.cmp
- Feature: make a toggleable shell buffer

- Feature: display all active lsp servers on current buffer
> https://neovim.io/doc/user/lsp.html

- Feature: warn if local lsp servers are not installed
- FIX: :QQ no longer works

------
# In-progress

- feature: change the color of the bar depending on the context
    - mode
    - focused pane

- feature:                  Make a shortcut to copy a file's path relative to the project root
- refactor(oil.nvim):       make <leader>= and <leader>- global shortcuts
- refactor(luasnip):        fine-tune luasnip remaps
- fix(treesitter-context):  not working in angular typescript projects for some reason
- featrue(Cattpucin):       find a way to make non focused panes lower on brightness or smth 

------
# Done
- fix(leap.nvim): make leaps ignore uppercase
- pwc for buffer files other than oil buffers
- Experiment: nvim-ufo
- Experiment: Luasnip
- Feature: Configure Neovim LSP integration without lsp0 (its currently deprecated)
- Feature: LuaSnip
- Fix: Lua lsp on nixos
    - more about it (3rd answer): https://stackoverflow.com/questions/75880481/cant-use-lua-lsp-in-neovim
    - perhaps find a way to use system-installed lsp servers together with mason?
    - perhaps switching to the nixos unstable branch might fix it?
- Fix: undotree treesitter error 
- Feature: Add DAP debugger support
- FIX: Cattpucin floating window 
- Experiment: nvim-treesitter-context
- Fix: neogit commit tab close behaviour
- Explore treesitter text objects for more useful motions
- ~Feat: add lualine~
    - ~https://github.com/nvim-lualine/lualine.nvim~
- Continue experimenting with snacks.nvim
- refactor: lazy load all possible plugins
- Feat: checks for linux install
- snacks.notify: add message title support; create custom notify function
- Fix: wilder.nvim python error
- ~Feat: better command mode autocomplete~
- Try: snacks.nvim
- Feature: install rainbow
    - https://github.com/luochen1990/rainbow
- Feature: indentation markers
    - Used snacks.nvim for this
- Feat: nvim-web-devicons
- Feat: keybind: serch across all files with ripgrep using telescope
- Feat: trouble.nvim
- Feature: terminal mode clear buffer function
- Fix: htew not working as expected on oil buffers. opening terminals at /tmp

