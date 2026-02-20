
# TODO

- feat: Which key
- feat: QQ on terminal mode cds to that terminal's path.
- feat:      make a toggleable shell buffer
- feat: display **all** active lsp servers on current buffer
- feat: warn if local lsp servers are not installed
- feat(statusbar): change the color of the bar depending on the context
    - mode
    - focused pane
- feat(telescope): support for lsp references

- fix(treesitter-context):  not working in angular typescript projects for some reason
- fix: <leader>Y for "+Y

- Experiment:   Replace cmp.nvim with blink.cmp


------
# In-progress

- fix(render-markdown): gitsigns not working if render-markdown is enabled



------
# DONE

- feat:                 add render-markdown
- refactor(luasnip):    fine-tune luasnip remaps
- feat(lsp):            add markdown lsp support 
- refactor(comp):       <Cr> does not autocomplete if there is no selection
- fix(treesitter):      add syntax highlight for markdown code boxes
- refactor: use trouble.nvim quickfix for "grr", other lsp related remaps and anything else that summons the quickfix window.
- feature(remaps): Make a shortcut to copy a file's path relative to the working directory
- feat(remaps): 
    ex   -> opens explorer relative to the file's path
    rex  -> opens explorer at the project root
    tew  -> opens terminal relative to the file's path
    rtew -> opens terminal at the project root

- refactor(oil.nvim):       make <leader>= and <leader>- global shortcuts
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

