#!/bin/bash
source ~/.dotfiles/ubuntu/utils.sh
source ~/.dotfiles/ubuntu/system.sh
set -e

if command_exists gsettings; then
	# Ensure computer doesn't go to sleep or lock while installing
	gsettings set org.gnome.desktop.screensaver lock-enabled false
	gsettings set org.gnome.desktop.session idle-delay 0
fi

if ! command_exists apt; then
	echo "This script is only compatible with Debian based systems."
	exit 1
fi

cat << 'EOF'
	
Updating and upgrading system packages...
EOF

sudo apt update
sudo apt upgrade

# Bootstrap curl
if ! [ -x "$(command -v curl)" ]; then
	sudo apt install curl -y
fi

################################################
# Install nix packaging system
################################################
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

for package in "${system_packages[@]}"; do
  if ! is_installed "$package"; then
    echo "Installing $package ..."
    sudo apt install "$package" -y
  else
    echo "$package is already installed. Skipping."
  fi
done

# Set the shell to zsh
chsh -s $(which zsh)

################################################
# Install snaps
################################################
if [ -n "$DISPLAY" ]; then
	echo "Installing snap packages..."
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
fi
################################################
# Install flatpacks
################################################
~/.dotfiles/ubuntu/flatpaks.sh
echo ""
echo "Installing other packages..."

echo ""
~/.dotfiles/ubuntu/optional.sh
~/.dotfiles/ubuntu/extensions.sh
~/.dotfiles/ubuntu/keybinds.sh

if command_exists gsettings; then
	gsettings set org.gnome.desktop.screensaver lock-enabled true
	gsettings set org.gnome.desktop.session idle-delay 300
fi
