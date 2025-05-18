#!/usr/bin/env bash

# Get next display index using jq one-liner and yabai
next_display=$(yabai -m query --displays | jq --argjson c "$(yabai -m query --windows --window | jq '.display')" 'map(.index) as $d | (($d | index($c) + 1) % ($d | length)) as $n | $d[$n]')

win_id=$(yabai -m query --windows --window | jq '.id')

for space in $(yabai -m query --spaces | jq '.[].index'); do
  yabai -m space "$space" --layout stack
done
echo $next_display
yabai -m window --display "${next_display}"
# now switch all spaces back to float
for space in $(yabai -m query --spaces | jq '.[].index'); do
  yabai -m space "$space" --layout float
done

yabai -m window --focus "$win_id"
yabai -m window --grid 1:1:0:0:1:1
