#!/bin/bash
if ! [ -x "$(command -v brew)" ]; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew install autogen
brew install cmake
brew install curl
brew install koekeishiya/formulae/skhd
brew install neofetch
brew install neofetch htop tmux
brew install ninja cmake gettext curl
brew install wallpaper

sh ~/.dotfiles/skhd/install.sh
