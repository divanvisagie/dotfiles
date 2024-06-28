#!/bin/bash
set -e

# Add zsh load files if the are not present
function config_loader_exists() {
  grep -q "for config_file" ~/.zshrc
}

if config_loader_exists; then
	exit 0
fi

cat << 'EOF'
for config_file ($HOME/.dotfiles/zsh/*.zsh); do
  source $config_file
done
EOF | tee -a ~/.zshrc

