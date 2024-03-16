#!/bin/bash
# wmctrl -r Telegram -b add,maximized_vert

is_open=$(wmctrl -l | grep "Telegram")
if [ -z "$is_open" ]; then
  telegram-desktop &
  sleep 1

  # Get screen width and height
  SCREEN_WIDTH=$(xdpyinfo | awk '/dimensions/{print $2}' | cut -d 'x' -f 1)
  SCREEN_HEIGHT=$(xdpyinfo | awk '/dimensions/{print $2}' | cut -d 'x' -f 2)

  THIRD=$(($SCREEN_WIDTH / 3))
  NEW_WIDTH=$THIRD

  # remove maximizations
  wmctrl -r "Telegram" -b remove,maximized_vert,maximized_horz
  wmctrl -r "Telegram" -e 0,0,0,$NEW_WIDTH,$SCREEN_HEIGHT

  NEW_X=$(($THIRD))
  # Center the window
  wmctrl -r "Telegram" -e 0,$NEW_X,0,-1,-1
  wmctrl -r "Telegram" -b add,maximized_vert

else
  wmctrl -a "Telegram"
fi
