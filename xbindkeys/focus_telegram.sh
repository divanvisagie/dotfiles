#!/bin/bash
wmctrl -a "Telegram" || telegram-desktop
# xdotool search --name 'Alacritty' windowactivate;
wmctrl -r Telegram -b add,maximized_vert
