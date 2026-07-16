# About

> [!info] 
> - This branch is a work in progress

</br>


# Current state of things
### Linux
#### Arch Debian Fedora OpenSUSE
* Everything works as intended

#### NixOS
* If an lsp server requires a dynamically linked executable, it won't work. 
* The solution is to use nix-ld to expose the .so file system wide, or install all lsp servers with nix.

&nbsp;
### Windows 10/11
* WLS: everything works after configuring the clipboard (win32yank).
* Native: some Linux specific features might not work (embedded shell commands, et cetera).

&nbsp;
### MacOS
* Mappings that use `Alt` may cause some problems due to the behaviour of the "opt" key

&nbsp;
### Android: <a href='https://github.com/termux/termux-app'>termux</a>
* Most <a href='https://github.com/mason-org/mason.nvim'>Mason</a> LSP servers work.
* Clipboard needs to be set up

</br>

# Installation

- Clone this repo and place its files in the neovim folder. (Linux: ~/.config/nvim)
- Be sure folder is empty beforehand.

> Linux/MacOS

```bash
[ -d ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.backup.$(date +%F_%T);
git clone https://github.com/bt-glv/nvim-config.git ~/.config/nvim;
```

- Open Neovim; open the Lazy.nvim dashboard ```:Lazy``` and press ```S```.

</br>


# LSP (autocomplete) support

- By default, this config is configured to use local lsp servers for lua, typescript and nix.
- That is due to problems installing those servers with <a href='https://github.com/mason-org/mason.nvim'>Mason</a> on NixOS systems.
- To change this behaviour and manage them automatically with Mason, or add more local lsp servers, see `lsp/settings`.

</br>

# Debuggers
> Currenty a work in progress
- So far, only delve (go) is set up and working

</br>

# Requirements
## Neovim
- Version: 0.12.x

## Dependencies

<ul>
    <li><a href='https://www.nerdfonts.com/'>Pacthed Nerd Fonts Font</a> (For Dev-Icons)</li>
    <li><a href='https://alacritty.org/'>Alacritty Terminal Emulator</a> (Can be replaced)</li>
    <li>node.js</li>
    <li>npm</li>
    <li>ripgrep</li>
    <li>wget</li>
    <li>unzip</li>
    <li>treesitter-cli</li>
    <li><a href='https://github.com/sharkdp/fd'>fd</a></li>
    <li>C compiler: gcc; clang</li>
</ul>

</br>

-------
# Attention

</br>

> [!attention] 
> Avoid running this config with "sudo -E". \
> Specially after starting it for the first time.\
> Running it with sudo will create a lot of root owned files all over ~/.npm, ~/.local/share/nvim/ and other locations, resulting in a lot of weird "permission denied" issues that are hard to track.

</br>
