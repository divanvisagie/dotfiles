#!/bin/bash

# Zsh setup
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Perform OS specific installs
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	sh ./ubuntu/install.sh
else
	sh ./macos/install.sh
fi

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

# Set up working directories if the do not exist
if [ ! -d ~/Projects ]; then
	mkdir ~/Projects
fi
if [ ! -d ~/Projects/com.github ]; then
	mkdir ~/Projects/com.github
fi

if [ ! -d ~/Projects/com.github/alacritty]; then
	mkdir ~/Projects/com.github/alacritty
fi

# Clone the alacritty repo if it does not exist
if [ ! -d ~/Projects/com.github/alacritty/alacritty ]; then
	cd ~/Projects/com.github/alacritty
	git clone https://github.com/alacritty/alacritty.git
	cd alacritty
	make install
	cd ~
fi

# Clone the nvim repo if it does not exist
if [ ! -d ~/Projects/com.github/neovim/neovim ]; then
	mkdir ~/Projects/com.github/neovim
	cd ~/Projects/com.github/neovim
	git clone git@github.com:neovim/neovim.git
	cd neovim
	make install
	cd ~
fi

# Install configs
sh ~/.dotfiles/tmux/install.sh
sh ~/.dotfiles/git/install.sh


# Install custom tools
cd ~/.dotfiles/scripts/dm
cargo install --path .
