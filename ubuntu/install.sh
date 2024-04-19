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
# install zsh and set it as the default shell
sudo apt install zsh -y
chsh -s $(which zsh)



