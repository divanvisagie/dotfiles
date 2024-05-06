if [ ! -d ~/.tmux ]; then
	ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
fi

if [ ! -d ~/.tmux/plugins/tpm ]; then
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# clone tmux if it does not exist
if [ ! -d ~/Projects/com.github/tmux/tmux ]; then
	mkdir ~/Projects/com.github/tmux
	cd ~/Projects/com.github/tmux
	git clone git@github.com:tmux/tmux.git
	cd tmux
	make install
	cd ~
fi
