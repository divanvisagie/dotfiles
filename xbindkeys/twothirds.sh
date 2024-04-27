#!/bin/bash

# Get screen width and height
SCREEN_WIDTH=$(xdpyinfo | awk '/dimensions/{print $2}' | cut -d 'x' -f 1)
SCREEN_HEIGHT=$(xdpyinfo | awk '/dimensions/{print $2}' | cut -d 'x' -f 2)

# Get the active window ID
ACTIVE_WIN_ID=$(xdotool getactivewindow)

# Unmaximize the window to allow moving it
wmctrl -i -r $ACTIVE_WIN_ID -b remove,maximized_vert,maximized_horz

# Wait a bit for the window manager to process the unmaximize command
sleep 0.1

## Calculate thirds
THIRD=$(($SCREEN_WIDTH / 3))

NEW_HEIGHT=$(($SCREEN_HEIGHT - 90))
NEW_WIDTH=$(($SCREEN_WIDTH * 2 / 3))

# Calculate new window position to center it
NEW_X=0
NEW_Y=$((($SCREEN_HEIGHT - $NEW_HEIGHT) / 2))

# Move the active window to the center of the screen
wmctrl -i -r $ACTIVE_WIN_ID -e 0,$NEW_X,$NEW_Y,$NEW_WIDTH,$NEW_HEIGHT

# Optional: Re-maximize the window if needed
wmctrl -i -r $ACTIVE_WIN_ID -b add,maximized_vert
