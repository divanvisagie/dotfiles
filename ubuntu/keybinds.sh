#!/bin/bash

gsettings set org.gnome.desktop.wm.keybindings switch-input-source "['<Alt><Ctrl>space']"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "[]"
gsettings set org.gnome.shell.keybindings toggle-overview "['<Super>space']"

gsettings set org.gnome.shell.keybindings switch-to-application-1 "['<Alt>b']"
gsettings set org.gnome.shell.keybindings switch-to-application-2 "['<Alt>t']"
gsettings set org.gnome.shell.keybindings switch-to-application-3 "['<Alt>g']"
gsettings set org.gnome.shell.keybindings switch-to-application-4 "['<Alt>f']"
gsettings set org.gnome.shell.keybindings switch-to-application-5 "['<Alt>m']"
