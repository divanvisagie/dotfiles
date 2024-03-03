ln -s ~/.dotfiles/alacritty ~/.config/alacritty

# Clone the alacritty repo if it does not exist
if [ ! -d ~/Projects/com.github/alacritty/alacritty ]; then
	mkdir ~/Projects/com.github/alacritty
	cd ~/Projects/com.github/alacritty
	git clone https://github.com/alacritty/alacritty.git
	cd alacritty
	make install
	cd ~
fi
