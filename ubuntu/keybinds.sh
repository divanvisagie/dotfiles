#!/bin/bash

# Use dconf to set the values
dconf write /org/gnome/desktop/wm/keybindings/switch-input-source "['<Alt><Ctrl>space']" 
dconf write /org/gnome/desktop/wm/keybindings/switch-input-source-backward "['']" 
dconf write /org/gnome/shell/keybindings/toggle-overview "['<Super>space']" 

dconf write /org/gnome/desktop/wm/keybindings/close "['<Alt>q']" 

dconf write /org/gnome/shell/keybindings/switch-to-application-1 "['<Alt>b']" 
dconf write /org/gnome/shell/keybindings/switch-to-application-2 "['<Alt>t']" 
dconf write /org/gnome/shell/keybindings/switch-to-application-3 "['<Alt>g']" 
dconf write /org/gnome/shell/keybindings/switch-to-application-4 "['<Alt>f']" 
dconf write /org/gnome/shell/keybindings/switch-to-application-5 "['<Alt>o']" 
dconf write /org/gnome/shell/keybindings/switch-to-application-6 "['<Alt>m']" 

# /var/lib/flatpak/exports/share/applications/
dconf write /org/gnome/shell/favorite-apps "['org.mozilla.firefox.desktop', 'org.wezfurlong.wezterm.desktop', 'org.telegram.desktop.desktop', 'org.gnome.Nautilus.desktop','md.obsidian.Obsidian.desktop','com.spotify.Client.desktop']" || log "Failed to set favorite-apps"

dconf write /org/gnome/desktop/wm/keybindings/toggle-fullscreen "['<Shift>F11']" 
