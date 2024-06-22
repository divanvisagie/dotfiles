#!/bin/bash

set -e

# Ensure computer doesn't go to sleep or lock while installing
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.session idle-delay 0

cat << 'EOF'
	
Updating and upgrading system packages...
EOF

sudo add-apt-repository -y ppa:neovim-ppa/stable
# Set up fastfetch
sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch
sudo apt update
sudo apt upgrade
clear

echo "Installing gum to bootstrap script..."
# gum spin --spinner dot --title "Updating package sources..." -- sudo apt update
# Install gum
if ! [ -x "$(command -v gum)" ]; then
	cd /tmp
	GUM_VERSION="0.14.1" # Use known good version
	wget -O gum.deb "https://github.com/charmbracelet/gum/releases/latest/download/gum_${GUM_VERSION}_amd64.deb"
	sudo apt install -y ./gum.deb
	rm gum.deb
	cd -
fi
clear

if [ -z "$MACHINE_TYPE" ]; then
	export MACHINE_TYPE=$(gum choose "Are you on a laptop or a desktop?" "laptop" "desktop")
fi

if [ -z "$XWINDOWS" ]; then
	export XWINDOWS=$(gum choose "Do you want to install X11 related packages?" "yes" "no")
fi


echo "Installing missing packages..."
# Define an array of packages to be installed
packages=(
	"autoconf"
	"avahi-daemon"
	"build-essential" 
	"cmake" 
	"curl" 
	"direnv"
	"fonts-dejavu"
	"gettext" 
	"git" 
	"gnome-shell-extensions" 
	"gnome-sushi"
	"gnome-tweaks"
	"heif-gdk-pixbuf" 
	"just" 
	"libevent-dev" # need for building tmux
	"libglib2.0-dev" 
	"libnsl-dev"
	"librust-servo-fontconfig-sys-dev" 
	"libssl-dev"
	"libxml2-dev"
	"ncurses-dev"
	"ninja-build"
	"openssh-server"
	"psensor"
	"tmux"
	"neovim"
	"fastfetch"
	"unzip"
	"wl-clipboard" 
	"wmctrl"
	"yacc"
)

# Function to check if a package is installed
is_installed() {
  dpkg -l "$1" &> /dev/null
}

for package in "${packages[@]}"; do
  if ! is_installed "$package"; then
    echo "Installing $package ..."
    sudo apt-get install "$package" -y
  else
    echo "$package is already installed. Skipping."
  fi
done

if [ "$XWINDOWS" = "yes" ]; then
	# X stuff for systems running Nvidia 
	sudo apt-get install xbindkeys -y
	sudo apt-get install xclip -y
	sudo apt-get install xdotool -y
fi
clear



################################################
# Install snaps
################################################
echo "Installing snap packages..."
if ! [ -x "$(command -v brave)" ]; then
	snap install telegram-desktop
	snap install brave
fi
echo ""

################################################
# Install flatpacks
################################################
echo "Installing flatpak packages..."
# Set up flatpak
if ! [ -x "$(command -v flatpak)" ]; then
	sudo apt install flatpak -y
	flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
fi

flatpak install flathub org.wezfurlong.wezterm
if [ "$MACHINE_TYPE" = "laptop" ]; then
	sudo apt install tlp
	flatpak install flathub com.github.d4nj1.tlpui
fi
clear
echo ""
echo "Installing other packages..."

################################################
# Install custom PPAs
################################################
if gum confirm "Do you want to install proton vpn"; then
	# Set up proton vpn
	if ! [ -x "$(command -v protonvpn-app)" ]; then
		wget https://repo2.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.3-3_all.deb
		sudo dpkg -i ./protonvpn-stable-release_1.0.3-3_all.deb && sudo apt update
		sudo apt-get install proton-vpn-gnome-desktop
		sudo apt-get install libayatana-appindicator3-1 gir1.2-ayatanaappindicator3-0.1 gnome-shell-extension-appindicator
		rm protonvpn-stable-release_1.0.3-3_all.deb
	fi
fi


# Github Cli
if ! [ -x "$(command -v gh)" ]; then
	curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg &&
		sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg &&
		echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null &&
		sudo apt update &&
		sudo apt install gh -y
fi

# Tailscale
if ! [ -x "$(command -v tailscale)" ]; then
	if gum confirm "Do you want to install tailscale?"; then
		curl -fsSL https://tailscale.com/install.sh | sh
		clear
	fi
fi

sudo apt-get update
sudo apt-get install neovim

# Desktop stuff
if [ "$XWINDOWS" = "yes" ]; then
	echo ""
	echo "Installing xbindkeys packages..."
	~/.dotfiles/xbindkeys/install.sh
fi
~/.dotfiles/ubuntu/extensions.sh
~/.dotfiles/ubuntu/keybinds.sh



# Revert to normal idle and lock settings
gsettings set org.gnome.desktop.screensaver lock-enabled true
gsettings set org.gnome.desktop.session idle-delay 300
