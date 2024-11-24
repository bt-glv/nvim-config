
## Get project path
vim.fn.getcwd()


## Get buffer number
vim.api.nvim_get_current_buf()


## Get buffer name
vim.api.nvim_buf_get_name(bufnr)
vim.api.nvim_buf_get_name(0) -- For current buffer


## feed keys

This function executes in parallel with your code unless specified not to.
Aka. it will send the request for some keys to be typed and immediately moves on to the next lua code line.

> Format
vim.api.nvim_feedkeys(keys::string,mode::string,replace_term_codes::boolean)

> Example
vim.api.nvim_feedkeys("q:","xn",false)


### modes

> Modes can be used in combination with one another
> Ex: xn xt

x       -> Makes the function wait till all keys are fed
t       -> keys will be handles as if they where typed
n       -> ""do not remap keys""


