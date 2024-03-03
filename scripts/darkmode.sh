#!/bin/bash

# Toggle dark mode
current_mode=$(osascript -e 'tell application "System Events" to tell appearance preferences to return dark mode')
alacritty_config=$(realpath ~/.dotfiles/alacritty/alacritty.toml) # Update this path to your alacritty config location if needed

light_theme="~/.config/alacritty/themes/themes/rose-pine-dawn.toml"
dark_theme="~/.config/alacritty/themes/themes/everforest_dark.toml"

if [ "$current_mode" == "true" ]; then
    sed -i '' "s|import = .*|import = [\"$light_theme\"]|" "$alacritty_config"
    osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to false'
    wallpaper set ~/.dotfiles/wallpapers/light.jpg
    echo "Switched to light mode."
else
    sed -i '' "s|import = .*|import = [\"$dark_theme\"]|" "$alacritty_config"
    osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to true'
    wallpaper set ~/.dotfiles/wallpapers/dark.png
    echo "Switched to dark mode."
fi
