#!/bin/bash
source ~/.dotfiles/utils.sh
set -e
if ! [ -x "$(command -v brew)" ]; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if ! command_exists "skhd"; then
	  brew install "koekeishiya/formulae/skhd"
fi

packages=(
	"curl"
	"gum"
	"wallpaper"
  "gcalcli"
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

echo "Setting up skhd..."
~/.dotfiles/skhd/install.sh

