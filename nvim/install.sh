#!/bin/bash
#set -e # The script will exit if it hits an error code

rm ~/.config/nvim
ln -s ~/.dotfiles/nvim/ ~/.config/
