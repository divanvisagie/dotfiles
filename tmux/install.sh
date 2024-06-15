if [ ! -d ~/.tmux ]; then
	ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
fi

if [ ! -d ~/.tmux/plugins/tpm ]; then
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# clone tmux if it does not exist
if [ ! -d ~/Projects/github.com/tmux/tmux ]; then
	mkdir ~/Projects/github.com/tmux
	cd ~/Projects/github.com/tmux
	git clone git@github.com:tmux/tmux.git
	cd tmux
	make install
	cd ~
fi
