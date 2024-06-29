#!/bin/bash
################################################
# Install custom PPAs and other optional software
################################################
source ~/.dotfiles/utils.sh
set -e

# Tailscale
if ! command_exists tailscale; then
	if gum confirm "Do you want to install tailscale?"; then
		curl -fsSL https://tailscale.com/install.sh | sh
	fi
fi
