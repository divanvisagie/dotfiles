#!/bin/bash

i3-msg -t subscribe -m '[ "window" ]' | while read -r msg; do
    # Find the number of windows in the current workspace
    num_windows=$(i3-msg -t get_tree | jq 'recurse(.nodes[]) | select(.type=="workspace") | select(.focused==true) | recurse(.nodes[]) | select(.type=="con") | length')

    # Get the screen width
    screen_width=$(xrandr | grep '*' | awk '{print $1}' | cut -d 'x' -f 1)

    if [ "$num_windows" -eq 1 ]; then
        # Calculate 2/3 dimensions
        width=$((screen_width * 2 / 3))

        # Calculate offset for centering the window
        offset=$(( (screen_width - width) / 2 ))

        # Resize and move the window
        i3-msg "resize set $width ppt"
        i3-msg "move position $offset px"
    fi
done
