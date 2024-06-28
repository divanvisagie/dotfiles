#!/bin/bash
################################################
# Install custom PPAs and other optional software
################################################
source ~/.dotfiles/utils.sh
set -e

# Set up proton vpn
if ! command_exists protonvpn-app; then
	if gum confirm "Do you want to install proton vpn"; then
		write_env "DOTFILES_PROTONVPN" "true"
		wget https://repo2.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.3-3_all.deb
		sudo dpkg -i ./protonvpn-stable-release_1.0.3-3_all.deb && sudo apt update
		sudo apt-get install proton-vpn-gnome-desktop
		sudo apt-get install libayatana-appindicator3-1 gir1.2-ayatanaappindicator3-0.1 gnome-shell-extension-appindicator
		rm protonvpn-stable-release_1.0.3-3_all.deb
	fi
fi

# Tailscale
if ! command_exists tailscale; then
	if gum confirm "Do you want to install tailscale?"; then
		curl -fsSL https://tailscale.com/install.sh | sh
	fi
fi
