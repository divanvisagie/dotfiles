#!/bin/bash
wmctrl -a "Alacritty" || alacritty
wmctrl -r Alacritty -b add,maximized_vert,maximized_horz
