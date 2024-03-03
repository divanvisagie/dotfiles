#!/bin/bash

# if we are on linux install the dependencies
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	sh ./ubuntu/install.sh
fi

# install useful rust tools
cargo install exa
cargo install bat
cargo install du-dust
cargo install ripgrep
cargo install cgip
cargo install cargo-watch

# Set up working directories if the do not exist
if [ ! -d ~/Projects ]; then
	mkdir ~/Projects
fi
if [ ! -d ~/Projects/com.github ]; then
	mkdir ~/Projects/com.github
fi

if [ ! -d ~/Projects/com.github/alacritty]; then
	mkdir ~/Projects/com.github/alacritty
fi

# Clone the alacritty repo if it does not exist
if [ ! -d ~/Projects/com.github/alacritty/alacritty ]; then
	cd ~/Projects/com.github/alacritty
	git clone https://github.com/alacritty/alacritty.git
	cd alacritty
	make install
	cd ~
fi

# Clone the nvim repo if it does not exist
if [ ! -d ~/Projects/com.github/neovim/neovim ]; then
	mkdir ~/Projects/com.github/neovim
	cd ~/Projects/com.github/neovim
	git clone git@github.com:neovim/neovim.git
	cd neovim
	make install
	cd ~
fi

sh ~/.dotfiles/tmux/install.sh
