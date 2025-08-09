#!/bin/sh

# Check if Terminal is running
if ! pgrep -x "Terminal" > /dev/null; then
    # If Terminal is not running, start it
    open -na "Terminal"
    sleep 1  # Wait a moment for Terminal to start
fi

# Open a new window in Terminal
osascript -e 'tell application "Terminal" to do script ""'
