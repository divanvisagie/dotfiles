ln -s ~/.dotfiles/xbindkeys/.xbindkeysrc ~/.xbindkeysrc

gsettings set org.gnome.desktop.wm.keybindings switch-input-source "['<Alt><Ctrl>space']"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "[]"
gsettings set org.gnome.shell.keybindings toggle-overview "['<Super>space']"
# gsettings set org.freedesktop.ibus.general.hotkey triggers "[]"
# gsettings set org.gnome.shell.keybindings open-application-menu "[]"
