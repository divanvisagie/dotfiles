#!/usr/bin/env bash

read -p "Update nvim ? (y/n) "
echo ''
if [[ $REPLY =~ ^[Yy]$ ]]; then 
    echo "Updating nvim..."
else
    exit 1
fi;


cp ~/dotfiles/nvim/init.vim ~/.config/nvim/

read -p "Do you want to install the required plugin manager? (y/n) " -n 1
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi;


