#!/bin/bash

gext_is_installed () {
	gnome-extensions list | grep -q "$1"
}

if ! [ -n "$DISPLAY" ]; then
	exit 0 # Dont install on headless systems
fi

sudo apt-get install -qq -y gnome-shell-extension-manager pipx

pipx install gnome-extensions-cli --system-site-packages

# Install new extensions
if ! gext_is_installed "blur-my-shell"; then
	gext install blur-my-shell@aunetx
fi

if ! gext_is_installed "tactile"; then
	gext install tactile@lundal.io
fi

if ! gext_is_installed "rounded-window-corners"; then
	gext install rounded-window-corners@fxgn
fi

# Compile gsettings schemas in order to be able to set them
sudo cp ~/.local/share/gnome-shell/extensions/blur-my-shell\@aunetx/schemas/org.gnome.shell.extensions.blur-my-shell.gschema.xml /usr/share/glib-2.0/schemas/
sudo cp ~/.local/share/gnome-shell/extensions/tactile@lundal.io/schemas/org.gnome.shell.extensions.tactile.gschema.xml /usr/share/glib-2.0/schemas/
sudo glib-compile-schemas /usr/share/glib-2.0/schemas/

# Configure Blur My Shell
# -----------------------
# Can be set like: gsettings set org.gnome.shell.extensions.blur-my-shell.panel blur true
# Load dconf settings for blur my shell
# captured with: dconf dump /org/gnome/shell/extensions/blur-my-shell/ > ~/.dotfiles/ubuntu/blur-my-shell-settings.dconf
dconf load /org/gnome/shell/extensions/blur-my-shell/ < ~/.dotfiles/ubuntu/blur-my-shell-settings.dconf

# if the machine type variable is empty we have to get it
if [ -z "$MACHINE_TYPE" ]; then
	MACHINE_TYPE=$(gum choose "Are you on a laptop or a desktop?" "laptop" "desktop")
fi
if [ "$MACHINE_TYPE" = "desktop" ]; then
	echo "Installing desktop settings"
	# Load dconf settings for tactile
	# captured with: dconf dump /org/gnome/shell/extensions/tactile/ > tactile-settings-desktop.dconf
	dconf load /org/gnome/shell/extensions/tactile/ < ~/.dotfiles/ubuntu/tactile-settings-desktop.dconf
else 
	echo "Installing laptop settings"
	# Load dconf settings for tactile
	# captured with: dconf dump /org/gnome/shell/extensions/tactile/ > tactile-settings.dconf
	dconf load /org/gnome/shell/extensions/tactile/ < ~/.dotfiles/ubuntu/tactile-settings-laptop.dconf
fi

# Disable animations when swapping workspace
gsettings set org.gnome.desktop.interface enable-animations false
