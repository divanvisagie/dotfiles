#!/bin/sh

#set -e # The script will exit if it hits an error code

# Create i3 config directory if it doesn't exist
mkdir -p ~/.config/i3

# Define source and destination
SOURCE_FILE=~/.dotfiles/i3/config
DEST_FILE=~/.config/i3/config

# Check if a file already exists at the destination
if [ -e "$DEST_FILE" ]; then
    # Check if it's already the correct symlink
    if [ -L "$DEST_FILE" ] && [ "$(readlink "$DEST_FILE")" = "$SOURCE_FILE" ]; then
        echo "i3 config is already linked correctly."
        exit 0
    fi

    echo "Error: A file already exists at $DEST_FILE."
    echo "Showing differences:"
    diff "$SOURCE_FILE" "$DEST_FILE"
    echo "Please back it up or remove it, then run this installer again."
    exit 1
fi

# Create the symlink
echo "Linking i3 config..."
ln -s "$SOURCE_FILE" "$DEST_FILE"
echo "i3 config linked successfully."
