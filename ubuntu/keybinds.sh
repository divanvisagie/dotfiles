#!/bin/bash

if ! [ -n "$DISPLAY" ]; then
	exit 0 # Dont install on headless systems
fi
gsettings set org.gnome.desktop.wm.keybindings switch-input-source "['<Alt><Ctrl>space']"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "[]"
gsettings set org.gnome.shell.keybindings toggle-overview "['<Super>space']"

gsettings set org.gnome.desktop.wm.keybindings close "['<Alt>q']"

gsettings set org.gnome.shell.keybindings switch-to-application-1 "['<Alt>b']" # Browser
gsettings set org.gnome.shell.keybindings switch-to-application-2 "['<Alt>t']" # Terminal
gsettings set org.gnome.shell.keybindings switch-to-application-3 "['<Alt>g']" # Telegram
gsettings set org.gnome.shell.keybindings switch-to-application-4 "['<Alt>f']" # Nautilus
gsettings set org.gnome.shell.keybindings switch-to-application-5 "['<Alt>m']" # Spotify

# Set Brave to position 1 in the dock
# Set Wezterm to position 2 in the dock
gsettings set org.gnome.shell favorite-apps "['brave_brave.desktop', 'org.wezfurlong.wezterm.desktop', 'telegram-desktop_telegram-desktop.desktop', 'org.gnome.Nautilus.desktop', 'spotify_spotify.desktop']"

# Full-screen with title/navigation bar
gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['<Shift>F11']"

