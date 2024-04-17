#!/bin/bash
sudo apt install build-essential -y
sudo apt install neofetch -y
sudo apt install xbindkeys -y
sudo apt install xclip -y
sudo apt install xdotool -y
sudo apt install wmctrl -y
sudo apt install openssh-server -y
sudo apt install git -y
sudo apt install avahi-daemon -y # install mdns 
sudo apt-get install libkstat-dev libkvm-dev libperfstat-dev libsendfile-dev


# install zsh and set it as the default shell
sudo apt install zsh -y
chsh -s $(which zsh)

# install powerlevel10k if it does not exist
if [ ! -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]; then
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
	echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
fi

# Install rust if not present 
if ! [ -x "$(command -v rustc)" ]; then
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi


