#!/bin/bash

# if we are on linux
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	# install the font 
	ln -s ~/.dotfiles/fonts/.fonts/MesloLGS\ NF\ Regular.ttf ~/.local/share/fonts/
	ln -s ~/.dotfiles/fonts/.fonts/MesloLGS\ NF\ Bold.ttf ~/.local/share/fonts/
	ln -s ~/.dotfiles/fonts/.fonts/MesloLGS\ NF\ Italic.ttf ~/.local/share/fonts/
	ln -s ~/.dotfiles/fonts/.fonts/MesloLGS\ NF\ Bold\ Italic.ttf ~/.local/share/fonts/
fi
