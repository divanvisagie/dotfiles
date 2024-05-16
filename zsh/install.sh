#!/bin/bash

#if there is no ~/.zshrc, create it
if [ ! -f ~/.zshrc ]; then
	ln -s ~/.dotfiles/zsh/ ~/.zsh
fi

# Zsh setup
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	sh ./ubuntu/install.sh
	sudo apt install zsh -y

	# if we are not in zsh, switch to it
	if [[ $SHELL != $(which zsh) ]]; then
		chsh -s $(which zsh)
		zsh
	fi
fi
