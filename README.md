# About

> This config is a work in progress
>
</br>

- Everything has been tested on Linux. Any distro should do.
- Everything works on Windows 10/11 under WLS 
- Some features might not work as expected on Windows (native Neovim), MacOS or Android.
- A lot may not work out of the box natively on Windows

# What doesn't work
NixOS: 
- Some Mason LSP servers wont start. (lua-language-server) </br>

Termux (Android): </br>
- Mason does not work
</br>


# Installation
- Clone this repo at the neovim folder. (Linux: ~/.config/nvim)
- Launch Neovim and sync Lazy.nvim by using the command below and then pressing "S":
```:Lazy```
- You might want to delete "lazy-lock.json"

# Required programs
<ul>
    <li>Alacritty (Can be changed for another terminal emulator on remaps.lua)</li>
    <li>npm</li>
    <li>node.js</li>
    <li>ripgrep</li>
    <li>fd</li>
    <li>C compiler: gcc; clang</li>
    <li>go (Optional)</li>
</ul>

</br>
</br>
