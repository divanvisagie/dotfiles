#!/bin/bash
sudo apt update
sudo apt upgrade

sudo apt-get install avahi-daemon -y # install mdns 
sudo apt-get install build-essential -y
sudo apt-get install curl git -y
sudo apt-get install heif-gdk-pixbuf -y # heic support
sudo apt-get install neofetch -y
sudo apt-get install openssh-server -y
sudo apt-get install gnome-sushi -y # quick look functionality
sudo apt-get install wmctrl -y
sudo apt-get install xbindkeys -y
sudo apt-get install xclip -y
sudo apt-get install xdotool -y
sudo apt-get install libxml2-dev -y
sudo apt-get install librust-servo-fontconfig-sys-dev -y
sudo apt-get install ninja-build -y
sudo apt-get install gnome-tweaks -y
sudo apt-get install ninja-build gettext cmake unzip curl build-essential -y #needed for neovim build
sudo apt-get install libnsl-dev -y #neovim needs this too
sudo apt-get install libssl-dev -y #needed for rust dev 
sudo apt-get install libglib2.0-dev -y
sudo apt-get install psensor -y
sudo apt-get install direnv -y
sudo apt-get install just -y
sudo apt-get install syncthing
sudo apt-get install gnome-shell-extensions

# set up flatpak
sudo apt-get install flatpak -y
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.github.d4nj1.tlpui

# set up proton vpn
wget https://repo2.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.3-3_all.deb
sudo dpkg -i ./protonvpn-stable-release_1.0.3-3_all.deb && sudo apt update
sudo apt-get install proton-vpn-gnome-desktop
sudo apt-get install libayatana-appindicator3-1 gir1.2-ayatanaappindicator3-0.1 gnome-shell-extension-appindicator
rm protonvpn-stable-release_1.0.3-3_all.deb

# Desktop stuff
sh ~/.dotfiles/xbindkeys/install.sh

# Tailscale
if ! [ -x "$(command -v tailscale)" ]; then
	curl -fsSL https://tailscale.com/install.sh | sh
fi
