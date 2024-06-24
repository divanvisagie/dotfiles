#!/bin/env zsh
# Move the configuration to the custom profile directory
cp ~/.dotfiles/nix/default.nix ~/.nix-profile-custom/default.nix
nix-env -i -f ~/.nix-profile-custom/default.nix


