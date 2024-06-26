#!/bin/bash

set -e

if [ -n "$DISPLAY" ]; then
	# Ensure computer doesn't go to sleep or lock while installing
	gsettings set org.gnome.desktop.screensaver lock-enabled false
	gsettings set org.gnome.desktop.session idle-delay 0
fi

cat << 'EOF'
	
Updating and upgrading system packages...
EOF

sudo apt update
sudo apt upgrade
clear

# Check if we're running under zsh
if [ -z "$ZSH_VERSION" ]; then
    echo "Switching to zsh..."

    # Install zsh if not already installed
    if ! command -v zsh &> /dev/null; then
        echo "zsh not found. Installing zsh..."
        sudo apt install -y zsh
    fi

    # Change the default shell to zsh for the current user
    chsh -s $(which zsh)

    # Re-run the script under zsh
    echo "Re-running script under zsh..."
    exec zsh "$0" "$@"

    # Exit the current shell script
    exit
else
    echo "Running under zsh. Continuing setup..."
fi

################################################
# Install nix
################################################
if ! [ -x "$(command -v curl)" ]; then
	sudo apt-get install curl -y
fi
if ! [ -x "$(command -v nix)" ]; then
	sh <(curl -L https://nixos.org/nix/install) --daemon
fi
~/.dotfiles/nix/install.sh

# Choose machine specific stuff for 
# windowing and power management settings
if [ -z "$MACHINE_TYPE" ]; then
	export MACHINE_TYPE=$(gum choose "Are you on a laptop or a desktop?" "laptop" "desktop")
fi

echo "Installing missing packages..."
# Define an array of packages to be installed
packages=(
	"avahi-daemon"
	"build-essential" 
	"curl" 
	"direnv"
	"fonts-dejavu"
	"gettext" 
	"git" 
	"gnome-shell-extensions" 
	"gnome-sushi"
	"gnome-tweaks"
	"heif-gdk-pixbuf" 
	"libglib2.0-dev" 
	"libnsl-dev"
	"librust-servo-fontconfig-sys-dev" 
	"libssl-dev"
	"libxml2-dev"
	"ncurses-dev"
	"openssh-server"
	"psensor"
	"unzip"
	"xclip"
	"wl-clipboard" 
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

clear

################################################
# Install snaps
################################################
echo "Installing snap packages..."
# Extracting snap package names into a list
snap_packages=(
	"telegram-desktop"
	"brave"
	"spotify"
)

# Iterate over the list and install each package if it's not already installed
for snap in "${snap_packages[@]}"; do
	if ! snap list | grep -q "^$snap"; then
		echo "$snap is not installed, installing..."
		snap install "$snap"
	else
		echo "$snap is already installed."
	fi
done
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

# Set up proton vpn
if ! [ -x "$(command -v protonvpn-app)" ]; then
	if gum confirm "Do you want to install proton vpn"; then
		wget https://repo2.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.3-3_all.deb
		sudo dpkg -i ./protonvpn-stable-release_1.0.3-3_all.deb && sudo apt update
		sudo apt-get install proton-vpn-gnome-desktop
		sudo apt-get install libayatana-appindicator3-1 gir1.2-ayatanaappindicator3-0.1 gnome-shell-extension-appindicator
		rm protonvpn-stable-release_1.0.3-3_all.deb
	fi
fi


# Tailscale
if ! [ -x "$(command -v tailscale)" ]; then
	if gum confirm "Do you want to install tailscale?"; then
		curl -fsSL https://tailscale.com/install.sh | sh
		clear
	fi
fi

~/.dotfiles/ubuntu/extensions.sh
~/.dotfiles/ubuntu/keybinds.sh


if [ -n "$DISPLAY" ]; then
	gsettings set org.gnome.desktop.screensaver lock-enabled true
	gsettings set org.gnome.desktop.session idle-delay 300
fi
