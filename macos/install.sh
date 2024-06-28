#!/bin/bash
source ~/.dotfiles/utils.sh
set -e
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
    log_info "$package is already installed. Skipping."
  fi
done

################################################
# Install nix
################################################
if ! [ -x "$(command -v nix)" ]; then
	sh <(curl -L https://nixos.org/nix/install)
fi
~/.dotfiles/nix/install.sh
echo "Setting up skhd..."
~/.dotfiles/skhd/install.sh

