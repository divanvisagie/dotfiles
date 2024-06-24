#!/bin/bash
set -e # The script will exit if it hits an error code
if [ ! -f ~/.dotfiles/alacritty ]; then
	ln -s ~/.dotfiles/alacritty/ ~/.config/
fi
