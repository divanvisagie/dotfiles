#!/bin/bash
sudo apt update
sudo apt upgrade
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
sudo apt install libssl-dev -y #needed for rust dev 
sudo apt install libglib2.0-dev -y
sudo apt install psensor -y
sudo apt install direnv -y

# install zsh and set it as the default shell
sudo apt install zsh -y
chsh -s $(which zsh)

# set up flatpak
sudo apt install flatpak -y
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.github.d4nj1.tlpui

# set up proton vpn
wget https://repo2.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.3-3_all.deb
sudo dpkg -i ./protonvpn-stable-release_1.0.3-3_all.deb && sudo apt update
sudo apt install proton-vpn-gnome-desktop
sudo apt install libayatana-appindicator3-1 gir1.2-ayatanaappindicator3-0.1 gnome-shell-extension-appindicator
