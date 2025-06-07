#!/bin/bash

# Create fastfetch config directory if it doesn't exist
mkdir -p ~/.config/fastfetch

# Remove existing config files if they exist
rm -f ~/.config/fastfetch/config.jsonc
rm -f ~/.config/fastfetch/logo.txt

# Create symbolic links to dotfiles
ln -s ~/.dotfiles/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc
ln -s ~/.dotfiles/fastfetch/logo.txt ~/.config/fastfetch/logo.txt