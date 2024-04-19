#!/bin/bash
if ! [ -x "$(command -v brew)" ]; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
brew install autogen
brew install cmake
brew install curl
brew install neofetch
brew install neofetch htop tmux
brew install ninja cmake gettext curl
brew install skhd
brew install wallpaper
