#!/bin/bash

set -e # The script will exit if it hits an error code

if [ ! -f ~/.tmux.conf ]; then
	ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
fi

