# About

> Work in Progress.

> Fully compatible with Linux
> On other platforms it might not work as intended (MacOS) or not work at all.
</br>


# Current state of things
### Linux
#### Arch/Debian/Fedora/OpenSUSE
> and most other "normal" distros
* Everything works as intended
#### NixOS
* Nixos cannot execute dynamically linked executables. <a href='https://github.com/mason-org/mason.nvim'>Mason</a> (integrated lsp manager plugin) relies on them to execute certain lsp(s). Thus, Mason may fail to install some of them.
* The solution is to install them locally with nix (package manager) and use that installation instead.

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
* Most <a href='https://github.com/mason-org/mason.nvim'>Mason</a> LSP servers work, some may not install at all.
* Clipboard does not work out of the box

</br>

# Installation

- Clone this repo and place its files in the neovim folder. (Linux: ~/.config/nvim)
- Be sure folder is empty beforehand.

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
- That is due to problems installing those servers with <a href='https://github.com/mason-org/mason.nvim'>Mason</a> on NixOS systems.
- To change this behaviour and manage them automatically with Mason, or add more local lsp servers, see `lsp/settings`.

</br>

# Debuggers
> Currenty a work in progress
- So far, only delve (go) is set up and working

</br>

# Requirements
## Neovim
- Version: 0.11.x\

## Dependencies

<ul>
    <li><a href='https://www.nerdfonts.com/'>Pacthed Nerd Fonts Font</a> (For Dev-Icons)</li>
    <li><a href='https://alacritty.org/'>Alacritty Terminal Emulator</a> (Can be replaced)</li>
    <li>node.js</li>
    <li>npm</li>
    <li>ripgrep</li>
    <li>wget</li>
    <li>unzip</li>
    <li><a href='https://github.com/sharkdp/fd'>fd</a></li>
    <li>C compiler: gcc; clang</li>
</ul>

</br>

-------
# Attention

</br>

> Avoid running this config with "sudo -E", specially after starting it for the first time.\
> This will create a lot of root owned files all over ~/.npm, ~/.local/share/nvim/ and other locations. Resulting in a lot of weird "permission denied" issues that are hard to track down.

</br>
