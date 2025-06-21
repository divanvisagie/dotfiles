#!/bin/bash

# Auto-generated rpm-ostree install script
# Generated on Sat Jun 21 12:38:55 PM CEST 2025

set -e

echo 'Installing layered packages...'
rpm-ostree install \
    cosmic-files \
    cosmic-settings \
    cosmic-store \
    direnv \
    distrobox \
    docker \
    docker-compose \
    fastfetch \
    fd-find \
    fzf \
    gnome-software \
    htop \
    mosquitto \
    mqttcli \
    neovim \
    podman-compose \
    rust-openssl-sys-devel \
    steam-devices \
    tailscale \
    texlive-lexend \
    tmux \
    wdisplays \
    yt-dlp \
    zoxide \
    zsh

echo 'Installation complete! Reboot to apply changes.'
