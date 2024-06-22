#!/bin/bash

if [ ! -f ~/.wezterm.lua ]; then
	ln -s ~/.dotfiles/wezterm/.wezterm.lua ~/.wezterm.lua
fi
