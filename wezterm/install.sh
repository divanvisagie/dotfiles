#!/bin/bash

if [ ! -f ~/.wezterm.lua ]; then
	rm ~/.wezterm.lua
	ln -s ~/.dotfiles/wezterm/.wezterm.lua ~/.wezterm.lua
fi
