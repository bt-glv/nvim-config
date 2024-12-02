# About
This config was made on Linux for Linux.</br>

Some features might not work as expected on Windows (native Neovim), MacOS or Android. </br></br>
Everything works on Windows 10/11 under WLS </br>
A lot of plugins and features might not work out of the box on native Neovim for Windows </br> 

# What does not work (confirmed)
NixOS: 
- Some Mason LSP servers wont start. (lua-language-server) </br>

Termux (Android): </br>
- Mason does not work
</br>


# Installation
- Clone this repo at the neovim folder. (Usually ~/.config/nvim)
- Launch Neovim and sync Lazy.nvim by using the following command then pressing "S":
```:Lazy<cr>```
- You might want to delete "lazy-lock.json"

# Required programs
<ul>
    <li>Alacritty (Can be changed for another terminal emulator on remaps.lua)</li>
    <li>Node.js -> npm</li>
    <li>ripgrep</li>
    <li>fd</li>
    <li>C compiler: gcc; clang; et cetera </li>
    <li>go (Optional)</li>
</ul>

</br>
</br>
-> This file is a work in progress 
