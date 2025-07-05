#!/bin/bash

# Auto-generated rpm-ostree install script
# Generated on Sat Jul  5 12:36:52 PM CEST 2025

set -e

echo 'Installing layered packages...'
rpm-ostree install \
    cmake \
    cosmic-files \
    cosmic-settings \
    cosmic-store \
    cosmic-term \
    direnv \
    distrobox \
    fastfetch \
    fd-find \
    fzf \
    gcc \
    gcc-c++ \
    geary \
    gnome-software \
    htop \
    make \
    mosquitto \
    mqttcli \
    neovim \
    ollama \
    perl \
    podman-compose \
    qemu-img \
    qemu-system-x86 \
    rust-openssl-sys-devel \
    rust-wayland-sys-devel \
    steam \
    tailscale \
    texlive-lexend \
    texlive-scheme-basic \
    tmux \
    unison \
    vlc-gui-qt \
    wdisplays \
    wtype \
    yt-dlp \
    zoxide \
    zsh

echo 'Installation complete! Reboot to apply changes.'
