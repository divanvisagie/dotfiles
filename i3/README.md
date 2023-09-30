## Cheatsheet

Open terminal: `Super+enter`

Open application: `Super+D`

Enter tab mode for windows: `Super+W`

Exit tab mode: `Super+E`

Navigate in tab mode `Super+Arrow Key`

Resize Window: `Super+R` Then `Arrow Key` Use `Esc` to exit resize mode

Move Window: `Super+Shift+Arrow`

Move workspace: `Super+Shift+workspace number`


### extra
mod+Shift+r to reload config

`xprop` to find window names


# Set Alacritty to dynamically floating and resize
for_window [class="Alacritty"] exec ~/.dotfiles/i3/resize.sh

# Set Google Chrome to dynamically floating and resize
for_window [class="Google-chrome"] exec ~/.dotfiles/i3/resize.sh

