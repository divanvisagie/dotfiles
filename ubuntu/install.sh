#!/bin/bash

# Ensure computer doesn't go to sleep or lock while installing
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.session idle-delay 0

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
sudo apt-get install gnome-shell-extensions -y
sudo apt install wl-clipboard -y

snap install brave

# Set up flatpak
sudo apt-get install flatpak -y
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.github.d4nj1.tlpui

# Set up proton vpn
wget https://repo2.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.3-3_all.deb
sudo dpkg -i ./protonvpn-stable-release_1.0.3-3_all.deb && sudo apt update
sudo apt-get install proton-vpn-gnome-desktop
sudo apt-get install libayatana-appindicator3-1 gir1.2-ayatanaappindicator3-0.1 gnome-shell-extension-appindicator
rm protonvpn-stable-release_1.0.3-3_all.deb

# Set up fastfetch
sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch
sudo apt update -y
sudo apt install -y fastfetch

# Github Cli
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg &&
	sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg &&
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null &&
	sudo apt update &&
	sudo apt install gh -y

# Tailscale
if ! [ -x "$(command -v tailscale)" ]; then
	curl -fsSL https://tailscale.com/install.sh | sh
fi

# Install gum
cd /tmp
GUM_VERSION="0.14.1" # Use known good version
wget -O gum.deb "https://github.com/charmbracelet/gum/releases/latest/download/gum_${GUM_VERSION}_amd64.deb"
sudo apt install -y ./gum.deb
rm gum.deb
cd -

# Desktop stuff
sh ~/.dotfiles/xbindkeys/install.sh
sh ~/.dotfiles/ubuntu/extensions.sh
sh ~/.dotfiles/ubuntu/keybinds.sh

# Revert to normal idle and lock settings
gsettings set org.gnome.desktop.screensaver lock-enabled true
gsettings set org.gnome.desktop.session idle-delay 300
