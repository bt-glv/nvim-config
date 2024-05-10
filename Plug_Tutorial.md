
# Required External programs
gcc | clang
ripgrep


# The basics
Install declared plugins
 :so %		-> If you are editing this file
 :PlugInstall

 Uninstalling plugins
 -- Remove the plugin(s) from your Plug call
 :PlugClean



# How to install PLUG

Link to the repo:
https://github.com/junegunn/vim-plug
curl -O https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

 To install, download the plug.vim file from the repo and place it in the autoload folder.

 ## Neovim
cd ~/.local/share/nvim/site/autoload
curl -O https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

 ## VIM
cd ~/.vim/autoload
curl -O https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

 ## Neovim (WINDOWS)
 C:\Users\<username>\AppData\Local\nvim\autoload
 -- Place the file on this folder
