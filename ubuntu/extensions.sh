#!/bin/bash

sudo apt install -y gnome-shell-extension-manager pipx
pipx install gnome-extensions-cli --system-site-packages

# Install new extensions
gext install blur-my-shell@aunetx
gext install tactile@lundal.io

# Compile gsettings schemas in order to be able to set them
sudo cp ~/.local/share/gnome-shell/extensions/blur-my-shell\@aunetx/schemas/org.gnome.shell.extensions.blur-my-shell.gschema.xml /usr/share/glib-2.0/schemas/
sudo cp ~/.local/share/gnome-shell/extensions/tactile@lundal.io/schemas/org.gnome.shell.extensions.tactile.gschema.xml /usr/share/glib-2.0/schemas/
sudo glib-compile-schemas /usr/share/glib-2.0/schemas/



# Configure Blur My Shell
# -----------------------
# Can be set like: gsettings set org.gnome.shell.extensions.blur-my-shell.panel blur true
# Load dconf settings for blur my shell
# captured with: dconf dump /org/gnome/shell/extensions/blur-my-shell/ > blur-my-shell-settings.dconf
dconf load /org/gnome/shell/extensions/blur-my-shell/ < ~/.dotfiles/ubuntu/blur-my-shell-settings.dconf

# if the machine type variable is empty we have to get it
if [ -z "$MACHINE_TYPE" ]; then
	MACHINE_TYPE=$(gum choose "Are you on a laptop or a desktop?" "laptop" "desktop")
fi
if [ "$MACHINE_TYPE" = "desktop" ]; then
	echo "Installing desktop settings"
	# Load dconf settings for tactile
	# captured with: dconf dump /org/gnome/shell/extensions/tactile/ > tactile-settings.dconf
    # dconf load /org/gnome/shell/extensions/tactile/ < ~/.dotfiles/ubuntu/tactile-settings.dconf
	gsettings set org.gnome.shell.extensions.tactile col-0 1
	gsettings set org.gnome.shell.extensions.tactile col-1 2
	gsettings set org.gnome.shell.extensions.tactile col-2 2
	gsettings set org.gnome.shell.extensions.tactile col-3 1
	gsettings set org.gnome.shell.extensions.tactile row-0 1
	gsettings set org.gnome.shell.extensions.tactile row-1 1
	gsettings set org.gnome.shell.extensions.tactile gap-size 8
else 
	echo "Installing laptop settings"
	# Load dconf settings for tactile
	# captured with: dconf dump /org/gnome/shell/extensions/tactile/ > tactile-settings.dconf
	dconf load /org/gnome/shell/extensions/tactile/ < ~/.dotfiles/ubuntu/tactile-settings-laptop.dconf
fi
