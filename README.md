# About
This config was made on and for Linux.</br>
Mason Lsp Servers and other features might not work as expected on Windows (native Neovim), MacOS or Android.
So far, little has been tested on Windows outside WSL.
</br>

# What dosen't work
NixOS: 
- Some Mason LSP servers wont start. (lua-language-server, others..) </br>

Termux (Android): </br>
- Mason does not work

</br>
-> This file is a work in progress 
</br>

# Installation
- Clone this repo at the neovim folder. (Usually ~/.config/nvim)
- Launch Neovim and sync Lazy.nvim by using the following command:
```":Lazy<cr>S"```
- You might want to delete "lazy-lock.json"

# Required programs for this config
<ul>
    <li>Alacritty (Can be changed for another terminal emulator)</li>
    <li>Node.js -> npm</li>
    <li>ripgrep</li>
    <li>fd</li>
    <li>C compiler: gcc; clang; et cetera </li>
    <li>go (Optional)</li>
</ul>
