if [ ! -d ~/.config/nvim ]; then
	ln -s ~/.dotfiles/nvim/ ~/.config/
fi

# Clone the nvim repo if it does not exist
if [ ! -d ~/Projects/com.github/neovim/neovim ]; then
	mkdir ~/Projects/com.github/neovim
	cd ~/Projects/com.github/neovim
	git clone git@github.com:neovim/neovim.git
fi

cd ~/Projects/com.github/neovim/neovim
## only build if nvim not present
if ! [ -x "$(command -v nvim)" ]; then
	make CMAKE_BUILD_TYPE=Release
	sudo make install
fi
cd ~

