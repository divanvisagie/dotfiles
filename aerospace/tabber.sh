#!/bin/sh
# winpick-choose — Aerospace + choose-gui
# deps: /opt/homebrew/bin/aerospace, /opt/homebrew/bin/choose

set -euo pipefail

AERO=${AERO:-/opt/homebrew/bin/aerospace}
CHOOSE=${CHOOSE:-/opt/homebrew/bin/choose}

# default = focused monitor; pass --all to see everything
SCOPE="--monitor focused"
[ "${1-}" = "--all" ] && SCOPE="--all"

# Use real tabs via $'...'; scripts pasted with '\t' will break awk -F '\t'
FORMAT=$'%{window-id}\t%{workspace}\t%{app-name}\t%{window-title}'

MENU_LINES="$(
  "$AERO" list-windows $SCOPE --format "$FORMAT" \
  | awk -F '\t' 'NF>=4 && length($4)>0 {
      # id \t Visible label
      printf "%s\t[%s] %s — %s\n", $1, $2, $3, $4
    }'
)"

[ -z "$MENU_LINES" ] && exit 0

SELECTION="$(printf '%s\n' "$MENU_LINES" | "$CHOOSE" "Windows")" || exit 0
[ -z "$SELECTION" ] && exit 0

WIN_ID="$(printf '%s' "$SELECTION" | cut -f1)"
[ -n "$WIN_ID" ] && exec "$AERO" focus --window-id "$WIN_ID"
