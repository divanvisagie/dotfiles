#!/bin/bash
wmctrl -a "Telegram" || telegram-desktop
wmctrl -r Telegram -b add,maximized_vert
