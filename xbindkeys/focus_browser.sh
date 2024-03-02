#!/bin/bash
wmctrl -a "Google Chrome" || google-chrome
wmctrl -r "Google Chrome" -b add,maximized_vert,maximized_horz
