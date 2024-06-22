#!/bin/bash
if [ ! -f ~/.xbindkeysrc ]; then
	rm ~/.xbindkeysrc
	ln -s ~/.dotfiles/xbindkeys/.xbindkeysrc ~/.xbindkeysrc
fi

