#!/bin/bash

set -e # The script will exit if it hits an error code

if [ ! -f ~/.tmux.conf ]; then
	rm ~/.tmux.conf
	ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
fi

