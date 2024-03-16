#!/bin/bash

# Get screen width and height
echo 'test'

# get active window
ACTIVE_WIN_ID=$(xdotool getactivewindow)

# check if maximized, unmaximize if so otherwise maximize
MAXIMIZED=$(xprop -id $ACTIVE_WIN_ID | grep '_NET_WM_STATE_MAXIMIZED_VERT')
if [ -z "$MAXIMIZED" ]; then
  echo "maximizing"
  wmctrl -i -r $ACTIVE_WIN_ID -b add,maximized_vert,maximized_horz
else
  echo "unmaximizing"
  wmctrl -i -r $ACTIVE_WIN_ID -b remove,maximized_vert,maximized_horz
fi


