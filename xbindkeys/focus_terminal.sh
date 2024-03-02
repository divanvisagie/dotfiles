#!/bin/bash
wmctrl -a "Alacritty" || alacritty
# xdotool search --name 'Alacritty' windowactivate;
wmctrl -r Alacritty -b add,maximized_vert,maximized_horz
