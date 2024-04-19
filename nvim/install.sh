ln -s ~/.dotfiles/nvim/ ~/.config/

# Clone the nvim repo if it does not exist
if [ ! -d ~/Projects/com.github/neovim/neovim ]; then
	mkdir ~/Projects/com.github/neovim
	cd ~/Projects/com.github/neovim
	git clone git@github.com:neovim/neovim.git
	cd neovim
	
	## only build if nvim not present
	if ! [ -x "$(command -v nvim)" ]; then
		make CMAKE_BUILD_TYPE=Release
		make install
	fi
	cd ~
fi

