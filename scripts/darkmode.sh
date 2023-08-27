#!/bin/bash

# Toggle dark mode
current_mode=$(osascript -e 'tell application "System Events" to tell appearance preferences to return dark mode')
alacritty_config=$(realpath ~/.dotfiles/alacritty/alacritty.yml)
if [ $current_mode == "true" ]; then
    yq eval 'del(.import[]) | .import = ["~/.config/alacritty/themes/themes/rose-pine-dawn.yaml"]' -i "$alacritty_config" 
    osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to false'
    echo "Switched to light mode."
else
    yq eval 'del(.import[]) | .import = ["~/.config/alacritty/themes/themes/everforest_dark.yaml"]' -i "$alacritty_config" 
    osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to true'
    echo "Switched to dark mode."
fi

