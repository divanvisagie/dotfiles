#!/bin/bash

#set -e # The script will exit if it hits an error code

# Create waybar config directory if it doesn't exist
mkdir -p ~/.config/waybar

# Remove existing waybar config files if they exist
if [ -f ~/.config/waybar/config.jsonc ]; then
	rm ~/.config/waybar/config.jsonc
fi

if [ -f ~/.config/waybar/style.css ]; then
	rm ~/.config/waybar/style.css
fi



# Create symlinks to our dotfiles
ln -s ~/.dotfiles/waybar/config.jsonc ~/.config/waybar/config.jsonc
ln -s ~/.dotfiles/waybar/style.css ~/.config/waybar/style.css