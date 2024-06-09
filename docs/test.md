How to bind-mount

sudo mount --bind ~/.config/nvim/lua ~/.config/nvim_configs/copilot/lua

- The folder on the receiving end must already exist
- It will replace that folder's content with the source (kinda)

The "data" folder path changes when you use this.
Use this command to check what it is, if needed:
lua print(vim.fn.stdpath("data")) 


The path given on $NVIM_APPNAME   ***BEGINS*** on ~/.confing.
Have that in mind.


