#!/bin/bash
sudo apt install avahi-daemon -y # install mdns 
sudo apt install build-essential -y
sudo apt install curl git -y
sudo apt install heif-gdk-pixbuf -y # heic support
sudo apt install libkstat-dev libkvm-dev libperfstat-dev libsendfile-dev #needed for compiling downloaded tools
sudo apt install neofetch -y
sudo apt install openssh-server -y
sudo apt install wmctrl -y
sudo apt install xbindkeys -y
sudo apt install xclip -y
sudo apt install xdotool -y
sudo apt install libxml2-dev -y
sudo apt install librust-servo-fontconfig-sys-dev -y
sudo apt install ninja-build -y
sudo apt install gnome-tweaks -y
sudo apt install ninja-build gettext cmake unzip curl build-essential -y #needed for neovim build

# install zsh and set it as the default shell
sudo apt install zsh -y
chsh -s $(which zsh)
zsh



