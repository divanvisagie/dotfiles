#!/bin/bash

if ! [ -x "$(command -v node)" ]; then
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
	export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
	nvm install --lts
	nvm use --lts
fi

# Perform OS specific installs
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	sh ./ubuntu/install.sh
else
	sh ./macos/install.sh
fi

sh ~/.dotfiles/zsh/install.sh
# Zsh setup
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Install rust if not present 
if ! [ -x "$(command -v rustc)" ]; then
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

# install useful rust tools
cargo install exa
cargo install bat
cargo install du-dust
cargo install ripgrep
cargo install cgip
cargo install hurl
cargo install cargo-watch
cargo install gitui --locked
cargo install zoxide

# Set up working directories if they do not exist
if [ ! -d ~/Projects ]; then
	mkdir ~/Projects
fi
if [ ! -d ~/Projects/com.github ]; then
	mkdir ~/Projects/com.github
fi

# Install configs
sh ~/.dotfiles/tmux/install.sh
sh ~/.dotfiles/git/install.sh
sh ~/.dotfiles/alacritty/install.sh
sh ~/.dotfiles/nvim/install.sh

# Install custom tools
cd ~/.dotfiles/scripts/dm
cargo install --path .
