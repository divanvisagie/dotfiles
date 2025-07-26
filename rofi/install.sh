#!/bin/sh

# Create rofi config directory if it doesn't exist
mkdir -p ~/.config/rofi

# Define source and destination
SOURCE_DIR=~/.dotfiles/rofi/themes
DEST_LINK=~/.config/rofi/themes

# Check if a file or directory already exists at the destination
if [ -e "$DEST_LINK" ] || [ -L "$DEST_LINK" ]; then
    # Check if it's already the correct symlink
    if [ -L "$DEST_LINK" ] && [ "$(readlink "$DEST_LINK")" = "$SOURCE_DIR" ]; then
        echo "Rofi themes directory is already linked correctly."
        exit 0
    fi

    echo "Error: A file or directory already exists at $DEST_LINK."
    echo "Please back it up or remove it, then run this installer again."
    exit 1
fi

# Create the symlink
echo "Linking Rofi themes directory..."
ln -s "$SOURCE_DIR" "$DEST_LINK"
echo "Rofi themes directory linked successfully."
