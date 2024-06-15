#!/bin/bash

if [ ! -f ~/.vimrc ]; then
	ln -s ~/.dotfiles/vim/.vimrc ~/.vimrc
fi
