# About

> This config is a work in progress.

> Made for Linux; other platforms might not work as intended out of the box or may be incompatible.
</br>


# Current state of things
### Linux
#### Arch/Debian/Fedora/OpenSUSE
> and most other "normal" distros
* Everything works as intended
#### NixOS
* Nixos cannot execute dynamically linked executables by default. This creates a problem when managing lsp servers locally with mason because some of them rely on dynamically linked executables. Mason will install the lsp servers and try to execute them, and it will fail.
* In cases like this, the solution is to install the lsp server with nix and set Neovim to use it.

&nbsp;
### Windows 10/11
* WLS: everything works after configuring the clipboard (win32yank)
* Native: some Linux specific features might not work (embedded shell commands, et cetera)

&nbsp;
### MacOS
* All mappings that use `Alt` as a modifier key are incompatible and need to be changed
* LSP servers managed by <a href='https://github.com/mason-org/mason.nvim'>Mason</a> are unstable

&nbsp;
### Android: <a href='https://github.com/termux/termux-app'>termux</a>
* Most <a href='https://github.com/mason-org/mason.nvim'>Mason</a> LSP servers work, some may not install.
* Clipboard does not work out of the box

</br>

# Installation

- Clone this repo and place its files at the neovim folder. (Linux: ~/.config/nvim)
- Be sure that the folder is empty beforehand

> Linux/MacOS
```bash
git clone https://github.com/bt-glv/nvim-config.git;
cd nvim-config;
mkdir -p ~/.config/nvim;
mv .* ~/.config/nvim;
cd ~/.config/nvim;
```

- Open Neovim; open the Lazy.nvim dashboard ```:Lazy``` and press ```S```.


</br>

# LSP (autocomplete) support

- By default, this config is configured to use local lsp servers for lua, typescript and nix.
- That is due to problems running those lsp servers with mason on NixOS systems, wich more often than not are used to develop this config.
- To change this behaviour and manage them automatically with mason, or add more local lsp servers, see `lsp/settings`.

</br>

# Debuggers
> Currenty a work in progress
- So far, only delve (go) is set up and working

</br>

# Requirements
## Neovim
- Version: 0.11.x

## Dependencies

<ul>
    <li><a href='https://www.nerdfonts.com/'>Pacthed Nerd Fonts Font</a> (For Dev-Icons)</li>
    <li><a href='https://alacritty.org/'>Alacritty Terminal Emulator</a> (Can be replaced)</li>
    <li>node.js</li>
    <li>npm</li>
    <li>ripgrep</li>
    <li><a href='https://github.com/sharkdp/fd'>fd</a></li>
    <li>C compiler: gcc; clang</li>
</ul>


