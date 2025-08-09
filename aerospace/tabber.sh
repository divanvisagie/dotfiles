#!/bin/sh
# winpick: pick any window via rofi, then focus it with Aerospace
# deps: aerospace, rofi
# usage:
#   winpick            # current monitor’s workspace(s)
#   winpick --all      # all monitors

set -euo pipefail

SCOPE="--monitor focused"
[ "${1-}" = "--all" ] && SCOPE="--all"

# Format: id<TAB>app<TAB>title
FORMAT='%{window-id}%{tab}%{app-name}%{tab}%{window-title}'

# Build the menu, skipping untitled windows, and show "App — Title"
SELECTION="$(
  aerospace list-windows $SCOPE --format "$FORMAT" \
  | awk -F '\t' 'NF>=3 && length($3) > 0 { printf "%s\t%s — %s\n",$1,$2,$3 }' \
  | rofi -dmenu -i -p 'Windows'
)"

# User cancelled
[ -z "${SELECTION}" ] && exit 0

WIN_ID=$(printf '%s' "$SELECTION" | awk -F '\t' '{print $1}')
[ -n "$WIN_ID" ] && exec aerospace focus --window-id "$WIN_ID"

