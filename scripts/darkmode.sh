#!/bin/bash

# Toggle dark mode
alacritty_config=$(realpath ~/.dotfiles/alacritty/alacritty.toml) # Update this path to your alacritty config location if needed

light_theme="~/.config/alacritty/themes/themes/rose-pine-dawn.toml"
dark_theme="~/.config/alacritty/themes/themes/everforest_dark.toml"

dark_wallpaper="~/.dotfiles/wallpapers/dark.png"
light_wallpaper="~/.dotfiles/wallpapers/light.jpg"

function set_for_macos() {
    current_mode=$(osascript -e 'tell application "System Events" to tell appearance preferences to return dark mode')
    if [ "$current_mode" == "true" ]; then
        sed -i '' "s|import = .*|import = [\"$light_theme\"]|" "$alacritty_config"
        osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to false'
        wallpaper set $light_wallpaper
        echo "Switched to light mode."
    else
        sed -i '' "s|import = .*|import = [\"$dark_theme\"]|" "$alacritty_config"
        osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to true'
        wallpaper set $dark_wallpaper
        echo "Switched to dark mode."
    fi
}

function set_for_ubuntu() {
    # This part is more complex as Ubuntu doesn't have a built-in dark mode toggle like macOS.
    # You'll need to adjust your theme settings manually or through scripts that modify your desktop environment settings.
    # For wallpaper, you can use `gsettings` as shown below.
    if [ "$current_mode" == "true" ]; then
        # Adjust the theme to light version if available and set light wallpaper
        gsettings set org.gnome.desktop.background picture-uri "file://$light_wallpaper"
        echo "Switched to light mode."
    else
        # Adjust the theme to dark version if available and set dark wallpaper
        gsettings set org.gnome.desktop.background picture-uri "file://$dark_wallpaper"
        echo "Switched to dark mode."
    fi
}

# Determine OS and call the appropriate function
OS=$(uname)
if [ "$OS" == "Darwin" ]; then
    echo "macOS detected"
    set_for_macos
elif [ "$OS" == "Linux" ]; then
    echo "Linux detected"
    # Assuming you're using GNOME on Ubuntu for wallpaper management.
    # You might need to adjust this for other desktop environments.
    current_mode=$(gsettings get org.gnome.desktop.interface gtk-theme | grep -q 'dark' && echo true || echo false)
    set_for_ubuntu
else
    echo "Unsupported OS"
fi
