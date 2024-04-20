ln -s ~/.dotfiles/alacritty/ ~/.config/

# Clone the alacritty repo if it does not exist
if [ ! -d ~/Projects/com.github/alacritty/alacritty ]; then
	mkdir ~/Projects/com.github/alacritty
	cd ~/Projects/com.github/alacritty
	git clone https://github.com/alacritty/alacritty.git
fi

cd ~/Projects/com.github/alacritty/alacritty
## only build if alacritty command not present
if ! [ -x "$(command -v alacritty)" ]; then
	cargo build --release
	sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
	sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
	sudo desktop-file-install extra/linux/Alacritty.desktop
	sudo update-desktop-database
fi
cd ~
