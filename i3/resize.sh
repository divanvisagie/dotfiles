#!/bin/bash

# Get screen width and height
width=$(xrandr | grep '*' | awk '{print $1}' | awk -Fx '{print $1}')
height=$(xrandr | grep '*' | awk '{print $1}' | awk -Fx '{print $2}')

# Calculate two-thirds for width and height
new_width=$((width * 2 / 3))
new_height=$((height - 90))

# Get the window ID of the currently focused window
window_id=$(xdotool getwindowfocus)

# Resize and move the window
i3-msg "[id=\"$window_id\"] floating enable, resize set $new_width $new_height, move position center"
