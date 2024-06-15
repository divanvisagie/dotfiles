#!/bin/bash

set -e # The script will exit if it hits an error code

if [ ! -f ~/.tmux.conf ]; then
	ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
fi

echo "Tmux is already installed via the package manager"
echo "but we can get a more recent version from source."
if ! gum confirm "Do you want to update/install tmux from source?"; then 
	exit 0
fi

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
	if gum confirm "Do you want to update tmux?"; then 
		git pull
		./autogen.sh
		./configure
		sudo make install
	fi
fi
cd ~
