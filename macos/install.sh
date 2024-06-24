#!/bin/bash
if ! [ -x "$(command -v brew)" ]; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi


packages=(
	"curl"
	"gum"
	"koekeishiya/formulae/skhd"
	"wallpaper"
)

is_installed() {
	which "$1" &> /dev/null
}

for package in "${packages[@]}"; do
  if ! is_installed "$package"; then
    echo "Installing $package ..."
    brew install "$package"
  else
    echo "$package is already installed. Skipping."
  fi
done


# brew install curl
# brew install gum
# brew install koekeishiya/formulae/skhd
# brew install wallpaper

# Install nix
# check if nix is installed
if ! [ -x "$(command -v nix)" ]; then
	sh <(curl -L https://nixos.org/nix/install)
fi
~/.dotfiles/nix/install.sh
~/.dotfiles/skhd/install.sh

# Fix alacritty font rendering
# https://github.com/alacritty/alacritty/issues/7333#issuecomment-1784737226
# defaults -currentHost write -g AppleFontSmoothing -int 0
# undo defaults set of font smoothing
defaults -currentHost delete -g AppleFontSmoothing

