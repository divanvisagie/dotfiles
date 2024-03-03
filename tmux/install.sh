ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf

# clone tmux if it does not exist
if [ ! -d ~/Projects/com.github/tmux/tmux ]; then
	mkdir ~/Projects/com.github/tmux
	cd ~/Projects/com.github/tmux
	git clone git@github.com:tmux/tmux.git
	cd tmux
	make install
	cd ~
fi
