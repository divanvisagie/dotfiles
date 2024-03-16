#!/bin/bash
# wmctrl -r "Google Chrome" -b add,maximized_vert,maximized_horz

# select Firefox if open
is_open=$(wmctrl -l | grep "Firefox")
if [ -z "$is_open" ]; then
	# Launch firefox in the background
	firefox &
	sleep 1
	# Get screen width and height
	SCREEN_WIDTH=$(xdpyinfo | awk '/dimensions/{print $2}' | cut -d 'x' -f 1)
	SCREEN_HEIGHT=$(xdpyinfo | awk '/dimensions/{print $2}' | cut -d 'x' -f 2)

	THIRD=$(($SCREEN_WIDTH / 3))
	NEW_WIDTH=$(($SCREEN_WIDTH - $THIRD))


	# remove maximizations
	wmctrl -r "Firefox" -b remove,maximized_vert,maximized_horz
	wmctrl -r "Firefox" -e 0,0,0,$NEW_WIDTH,$SCREEN_HEIGHT

	NEW_X=$(($THIRD/ 2))
	# Center the window
	wmctrl -r "Firefox" -e 0,$NEW_X,0,-1,-1

	wmctrl -r "Firefox" -b add,maximized_vert
else
  	wmctrl -a "Firefox"
fi

