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
brew install just

sh ~/.dotfiles/skhd/install.sh

# Fix alacritty font rendering
# https://github.com/alacritty/alacritty/issues/7333#issuecomment-1784737226
defaults -currentHost write -g AppleFontSmoothing -int 0
