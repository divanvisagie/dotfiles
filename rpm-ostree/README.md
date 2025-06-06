# RPM-OSTree Package Management Scripts

This directory contains scripts to help manage layered packages in rpm-ostree systems (like Fedora Silverblue, Kinoite, Sericea, etc.).

## Scripts

### `get.sh`

A utility script to extract and manage layered packages from your rpm-ostree deployment.

#### Usage

**List current layered packages:**
```bash
./get.sh
```

This will output a clean, sorted list of all layered packages installed on your currently booted deployment:
```
cosmic-files
cosmic-settings
direnv
distrobox
fastfetch
fzf
gnome-software
htop
neovim
podman-compose
rust-openssl-sys-devel
tailscale
tmux
wdisplays
zoxide
zsh
```

**Generate installation script:**
```bash
./get.sh --generate
```

This will generate a complete bash script that can be used to reinstall all your current layered packages on a fresh system:
```bash
#!/bin/bash

# Auto-generated rpm-ostree install script
# Generated on Wed Jan 15 12:34:56 UTC 2025

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
```

#### Examples

**Save package list to file:**
```bash
./get.sh > my-packages.txt
```

**Generate and save install script:**
```bash
./get.sh --generate > install-packages.sh
chmod +x install-packages.sh
```

**Use the generated script on a new system:**
```bash
./install-packages.sh
```

## Requirements

- `jq` - JSON processor (usually available on most modern Linux distributions)
- `rpm-ostree` - Package management tool for ostree-based systems

## Notes

- The script only extracts packages from the currently **booted** deployment
- Generated install scripts include error handling (`set -e`) to stop on any errors
- After running the generated install script, you'll need to reboot to apply the changes
- This is particularly useful for:
  - Backing up your package configuration
  - Setting up new systems with the same packages
  - Documenting your system setup