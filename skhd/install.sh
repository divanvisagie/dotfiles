# create if does not exist
if [ ! -d ~/.config ]; then
	mkdir ~/.config
fi

if [ ! -d ~/.config/skhd ]; then
	mkdir ~/.config/skhd
fi

ln -s ~/.dotfiles/skhd/.skhdrc ~/.skhdrc
