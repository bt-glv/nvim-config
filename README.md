# About

</br>


# Current state of things
### Linux
#### Arch Debian Fedora OpenSUSE
* Everything works as intended.

#### NixOS
* If an lsp server requires a dynamically linked executable, it won't work. 
* Use nix-ld to expose the .so file system wide, or install all lsp servers with nix.

&nbsp;
### Windows 10/11
* WLS: everything works after configuring the clipboard (win32yank).
* Native: some Linux specific features might not work (shell commands, etc).

&nbsp;
### MacOS
* Mappings that use `Alt` may cause some problems due to the behaviour of the "opt" key

&nbsp;
### Android: <a href='https://github.com/termux/termux-app'>termux</a>
* Most <a href='https://github.com/mason-org/mason.nvim'>Mason</a> LSP servers work out of the box.
* Clipboard needs to be set up.

</br>

# Installation

- Install GIT.
- Install all other dependencies.
- Clone this repository at the neovim config folder. 
- Open the Lazy.nvim dashboard ```:Lazy``` and press ```S```.

## Install Scripts (w/ backup)
###  Linux/MacOS
```bash
[ -d ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.backup.$(date +%F_%T);
git clone https://github.com/bt-glv/nvim-config.git ~/.config/nvim;
```

### Windows
```powershell
$nvimPath = "$HOME\AppData\Local\nvim"
if (Test-Path $nvimPath) {
    $timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
    Move-Item -Path $nvimPath -Destination "$nvimPath.backup.$timestamp"
}
git clone https://github.com/bt-glv/nvim-config.git $nvimPath
```

</br>

# LSP support
> (autocomplete)

- By default, this config is configured to use local lsp servers for lua, typescript and nix.
- That is due to problems installing those servers with <a href='https://github.com/mason-org/mason.nvim'>Mason</a> on NixOS systems.
- To change this behaviour and manage them automatically with Mason, or add more local lsp servers, see `lsp/settings`.

</br>

# Treesitter
> (Per language styling and textobjects)

Parsers are installed with <a href="https://github.com/nvim-treesitter/nvim-treesitter">nvim-treesitter</a>.

Configured parsers in this config: `lua, vim, vimdoc, javascript, html, css, typescript, markdown_inline, markdown, latex, java, python, go, c, bash, diff, query, json, xml, yaml, nix`


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
    <li><a href='https://www.nerdfonts.com/'>Pacthed Nerd Fonts Font</a> (Optional)</li>
    <li><a href='https://alacritty.org/'>Alacritty Terminal Emulator</a> (Optional) (Can be replaced)</li>
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

