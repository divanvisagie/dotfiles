#!/bin/bash

# Auto-generated rpm-ostree install script
# Generated on Fri  6 Jun 22:53:34 CEST 2025

set -e

echo 'Installing layered packages...'
rpm-ostree install \
    cosmic-files \
    cosmic-settings \
    direnv \
    distrobox \
    fastfetch \
    fzf \
    gnome-software \
    htop \
    neovim \
    podman-compose \
    rust-openssl-sys-devel \
    tailscale \
    tmux \
    wdisplays \
    zoxide \
    zsh

echo 'Installation complete! Reboot to apply changes.'
