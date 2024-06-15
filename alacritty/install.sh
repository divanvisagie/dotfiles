#!/bin/bash
set -e # The script will exit if it hits an error code
if [ ! -d ~/.dotfiles/alacritty ]; then
	ln -s ~/.dotfiles/alacritty/ ~/.config/
fi

# Clone the alacritty repo if it does not exist
if [ ! -d ~/Projects/github.com/alacritty/alacritty ]; then
	mkdir ~/Projects/github.com/alacritty
	cd ~/Projects/github.com/alacritty
	git clone https://github.com/alacritty/alacritty.git
fi

cd ~/Projects/github.com/alacritty/alacritty
## only build if alacritty command not present
if ! [ -x "$(command -v alacritty)" ]; then
	cargo build --release
	sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
	sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
	sudo desktop-file-install extra/linux/Alacritty.desktop
	sudo update-desktop-database
else 
	gum confirm "Do you want to update alacritty?"
	git pull
	cargo build --release
	sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
	sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
fi
cd ~/.dotfiles
