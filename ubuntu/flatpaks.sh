#!/bin/bash
source ~/.dotfiles/utils.sh
set -e
################################################
# Install flatpacks
################################################
echo "Installing flatpak packages..."
# Set up flatpak
if ! [ -x "$(command -v flatpak)" ]; then
	sudo apt install -y flatpak
	sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
fi

if [ -n "$DISPLAY" ]; then
	flatpak install --or-update flathub ch.protonmail.protonmail-bridge
	flatpak install --or-update flathub com.github.finefindus.eyedropper
	flatpak install --or-update flathub com.protonvpn.www
	flatpak install --or-update flathub me.proton.Pass
	flatpak install --or-update flathub org.wezfurlong.wezterm
	flatpak install --or-update flathub md.obsidian.Obsidian
fi

if [ "$MACHINE_TYPE" = "laptop" ]; then
	if ! command_exists "tlp"; then
		echo "Installing tlp..."
		sudo apt-get install tlp
	fi
	if [ -n "$DISPLAY" ]; then
		flatpak install --or-update flathub com.github.d4nj1.tlpui
	fi
fi
