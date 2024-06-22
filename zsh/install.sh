#!/bin/bash

#if there is no ~/.zshrc, create it
if [ ! -d ~/.zsh ]; then
	rm ~/.zsh
	ln -s ~/.dotfiles/zsh ~/.zsh
fi

# Starship prompt
curl -sS https://starship.rs/install.sh | sh

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	sh ./ubuntu/install.sh
	sudo apt install zsh -y

	# if we are not in zsh, switch to it
	if [[ $SHELL != $(which zsh) ]]; then
		chsh -s $(which zsh)
		zsh
	fi
fi
