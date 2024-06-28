#!/bin/bash

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
	flatpak install flathub org.wezfurlong.wezterm
fi
if [ "$MACHINE_TYPE" = "laptop" ]; then
	if ! is_installed "tlp"; then
		echo "Installing tlp..."
		sudo apt-get install tlp
	fi
	if [ -n "$DISPLAY" ]; then
		flatpak install flathub com.github.d4nj1.tlpui
	fi
fi
