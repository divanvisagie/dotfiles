#!/bin/bash

set -e # The script will exit if it hits an error code

if [ ! -f ~/.tmux.conf ]; then
	ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
fi

gum confirm "Do you want to update/install tmux from source?"

# Clone tmux if it does not exist
if [ ! -d ~/Projects/github.com/tmux/tmux ]; then
	mkdir ~/Projects/github.com/tmux
	cd ~/Projects/github.com/tmux
	git clone git@github.com:tmux/tmux.git
	cd tmux
fi

cd ~/Projects/github.com/tmux/tmux
if ! [ -x "$(command -v tmux)" ]; then
	./autogen.sh
	./configure && make
	sudo make install
else 
	gum confirm "Do you want to update tmux?"
	git pull
	./autogen.sh
	./configure
	sudo make install
fi
cd ~
