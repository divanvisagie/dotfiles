#!/bin/bash
source ~/.dotfiles/ubuntu/utils.sh
source ~/.dotfiles/ubuntu/packages.sh
source ~/.dotfiles/utils.sh
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
if ! command_exists curl; then
	sudo apt install curl -y
fi

################################################
# Install nix packaging system
################################################
if ! command_exists nix; then
	sh <(curl -L https://nixos.org/nix/install) --daemon
	exec $SHELL
fi
~/.dotfiles/nix/install.sh

# Choose machine specific stuff for 
# windowing and power management settings
if [ -z "$MACHINE_TYPE" ]; then
	export MACHINE_TYPE=$(gum choose "Are you on a laptop or a desktop?" "laptop" "desktop")
	write_env "MACHINE_TYPE" "$MACHINE_TYPE"
fi

echo "Installing missing packages..."

for package in "${system_packages[@]}"; do
  if ! is_installed "$package"; then
    echo "Installing $package ..."
    sudo apt install "$package" -y
  else
    log_info "$package is already installed. Skipping."
  fi
done
snap install telegram-desktop

# Set the shell to zsh if it isnt
if [ "$SHELL" != "/usr/bin/zsh" ]; then
	chsh -s $(which zsh)
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
