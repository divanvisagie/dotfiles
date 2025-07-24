#!/bin/sh

#set -e # The script will exit if it hits an error code

# Create .config directory if it doesn't exist
mkdir -p ~/.config

# Define source and destination
SOURCE_DIR=~/.dotfiles/nvim
DEST_LINK=~/.config/nvim

# Check if a file or directory already exists at the destination
if [ -e "$DEST_LINK" ]; then
    # Check if it's already the correct symlink
    if [ -L "$DEST_LINK" ] && [ "$(readlink "$DEST_LINK")" = "$SOURCE_DIR" ]; then
        echo "nvim config is already linked correctly."
        exit 0
    fi

    echo "Error: A file or directory already exists at $DEST_LINK."
    echo "Please back it up or remove it, then run this installer again."
    exit 1
fi

# Create the symlink
echo "Linking nvim config..."
ln -s "$SOURCE_DIR" "$DEST_LINK"
echo "nvim config linked successfully."
