#!/bin/bash
# Create if does not exist
if [ ! -d ~/.config ]; then
	mkdir -p ~/.config
fi

if [ ! -d ~/.config/skhd ]; then
	mkdir -p ~/.config/skhd
fi

ln -s ~/.dotfiles/skhd/.skhdrc ~/.skhdrc
