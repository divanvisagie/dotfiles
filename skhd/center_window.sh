#!/usr/bin/env bash

# Get screen dimensions using system_profiler (or you can use other tools)
screen_info=$(osascript -e 'tell application "Finder" to get bounds of window of desktop')
# e.g. "0, 0, 1920, 1080"
IFS=', ' read -r _ _ screen_width screen_height <<< "$screen_info"

# Get front window size using AppleScript
win_size=$(osascript -e '
tell application "System Events"
    set frontApp to first application process whose frontmost is true
    tell frontApp
        set win to front window
        set winSize to size of win
        set winWidth to item 1 of winSize as integer
        set winHeight to item 2 of winSize as integer
        return (winWidth as text) & "," & (winHeight as text)
    end tell
end tell
')

win_width=$(echo "$win_size" | cut -d, -f1)
win_height=$(echo "$win_size" | cut -d, -f2)

echo "Raw win_size: '$win_size'"
echo "Screen size: ${screen_width}x${screen_height}"
echo "Window size: ${win_width}x${win_height}"

# Calculate center
center_x=$(( (screen_width - win_width) / 2 ))
center_y=$(( (screen_height - win_height) / 2 ))

# Use AppleScript to move the window
osascript <<END
tell application "System Events"
    set frontApp to first application process whose frontmost is true
    tell frontApp
        set position of front window to {$center_x, $center_y}
    end tell
end tell
END
