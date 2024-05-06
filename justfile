main:
	echo 'Select an item to install'
	@just -l | grep -v 'main'

tmux:
	./tmux/install.sh

vim:
	./vim/install.sh

nvim:
	./nvim/install.sh

zsh: 
	./zsh/install.sh

terminal:
	./alacritty/install.sh
