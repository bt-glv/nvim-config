# About

> This config is a work in progress.
> Made for Linux; other platforms might not work out of the box or be incompatible.
</br>


# Current state of things
#### Linux
- Everything is working as intended

#### Windows 10/11
* WLS: everything works after configuring the clipboard (win32yank)
* Native: some Linux specific features might not work (embedded shell commands, et cetera)

#### MacOS
* All key mappings that use the alt key as a modifier are incompatible
* Mason LSP servers are unstable

#### Android (termux)
* Mason straight up doesn't work no matter what

</br>

# Installation

- Clone this repo and place its files at the neovim folder. (Linux: ~/.config/nvim)
- Be sure that the folder is empty beforehand

> Linux
```bash
git clone https://github.com/bt-glv/nvim-config.git;
cd nvim-config;
mkdir -p ~/.config/nvim;
mv .* ~/.config/nvim;
```

- Open Neovim and sync Lazy.nvim by using the command below and then pressing "S":
```:Lazy```

</br>

# Requirements

<h2>Neovim</h2>
<h4>Version: 0.11.x</h4>
&nbsp;
<h2>Dependencies</h2>
<ul>
    <li>Alacritty</li>
    <li>npm</li>
    <li>node.js</li>
    <li>ripgrep</li>
    <li>fd</li>
    <li>C compiler: gcc; clang</li>
</ul>



