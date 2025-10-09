# About

> This config is a work in progress.

> Made for Linux; other platforms might not work as intended out of the box or may be incompatible.
</br>


# Current state of things
#### Linux
- Everything is working as intended

#### Windows 10/11
* WLS: everything works after configuring the clipboard (win32yank)
* Native: some Linux specific features might not work (embedded shell commands, et cetera)

#### MacOS
* All mappings that use `Alt` as a modifier key are incompatible and need to be changed
* LSP servers managed by <a href='https://github.com/mason-org/mason.nvim'>Mason</a> are unstable

#### Android: <a href='https://github.com/termux/termux-app'>termux</a>
* Some <a href='https://github.com/mason-org/mason.nvim'>Mason</a> LSP servers may not install
> Most <a href='https://github.com/mason-org/mason.nvim'>Mason</a> LSP servers work now
</br>

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
- To manage them automatically with mason, or add more local lsp servers, see `lsp/settings`.

</br>

# Debuggers
> Currenty a work in progress
- So far, only delve (go) is set up and working

</br>

# Requirements

&nbsp;
<h2>Neovim</h2>
<h4>Version: 0.11.x</h4>
&nbsp;
<h2>Dependencies</h2>
<ul>
    <li><a href='https://www.nerdfonts.com/'>Pacthed Nerd Fonts Font</a> (For Dev-Icons)</li>
    <li><a href='https://alacritty.org/'>Alacritty Terminal Emulator</a> (Can be replaced)</li>
    <li>node.js</li>
    <li>npm</li>
    <li>ripgrep</li>
    <li><a href='https://github.com/sharkdp/fd'>fd</a></li>
    <li>C compiler: gcc; clang</li>
</ul>


