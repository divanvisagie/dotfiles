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

# Get active window width and height
WIN_WIDTH=$(xwininfo -id $ACTIVE_WIN_ID | grep 'Width:' | awk '{print $2}')
WIN_HEIGHT=$(xwininfo -id $ACTIVE_WIN_ID | grep 'Height:' | awk '{print $2}')

# Calculate new window position to center it
NEW_X=$((($SCREEN_WIDTH - $WIN_WIDTH) / 2))
NEW_Y=$((($SCREEN_HEIGHT - $WIN_HEIGHT) / 2))

# Move the active window to the center of the screen
wmctrl -i -r $ACTIVE_WIN_ID -e 0,$NEW_X,$NEW_Y,-1,-1

# Optional: Re-maximize the window if needed
wmctrl -i -r $ACTIVE_WIN_ID -b add,maximized_vert
