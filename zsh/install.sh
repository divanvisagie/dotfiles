#!/bin/bash

#if there is no ~/.zshrc, create it
if [ ! -d ~/.zsh ]; then
	rm ~/.zsh
	ln -s ~/.dotfiles/zsh ~/.zsh
fi

# Starship prompt
if ! [ -x "$(command -v starship)" ]; then
	curl -sS https://starship.rs/install.sh | sh
fi
