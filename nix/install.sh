#!/bin/bash

# Move the configuration to the custom profile directory
mkdir -p ~/.nix-profile-custom

cp ~/.dotfiles/nix/default.nix ~/.nix-profile-custom/default.nix
cp config.nix ~/.config/nixpkgs/config.nix

nix-env -i -f ~/.nix-profile-custom/default.nix
