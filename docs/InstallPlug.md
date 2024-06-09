# The basics
Install declared plugins
 :so %		
 :PlugInstall

 Uninstall plugins
 -- Remove the plugin(s) from your Plug call
 :PlugClean



# How to install PLUG

https://github.com/junegunn/vim-plug
curl -O https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

To install, download the plug.vim file from the repo and place it in the autoload folder.

 ## Linux
 ```bash
mkdir -p ~/.local/share/nvim/site/autoload
cd ~/.local/share/nvim/site/autoload
curl -O https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

 ## Windows 
 C:\Users\<username>\AppData\Local\nvim\autoload
