

# Feature a didn't know
ctrl-q in insert mode gives you terminal codes of keys and vim key tags.
You don't need to parse termcodes.


lua vim.api.nvim_feedkeys("oBullshit","xn",false)
> I used <c-q><esc> to generate the terminal code after "oBullshit".
> the code above works

You can also use this feature with /g searches

# Nvim Lua functions

## List buffer variables
:echo keys(b:)



