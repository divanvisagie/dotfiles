ln -s ~/.dotfiles/alacritty/ ~/.config/

# Clone the alacritty repo if it does not exist
if [ ! -d ~/Projects/com.github/alacritty/alacritty ]; then
	mkdir ~/Projects/com.github/alacritty
	cd ~/Projects/com.github/alacritty
	git clone https://github.com/alacritty/alacritty.git
	cd alacritty

	## only build if alacritty command not present
	if ! [ -x "$(command -v alacritty)" ]; then
		cargo install --path .
	fi
	cd ~
fi
