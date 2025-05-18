#!/usr/bin/env bash

# Get next display index using jq one-liner and yabai
next_display=$(yabai -m query --displays | jq --argjson c "$(yabai -m query --windows --window | jq '.display')" 'map(.index) as $d | (($d | index($c) + 1) % ($d | length)) as $n | $d[$n]')


for space in $(yabai -m query --spaces | jq '.[].index'); do
  yabai -m space "$space" --layout stack
done
echo $next_display
yabai -m window --display "${next_display}"
# now switch all spaces back to float
for space in $(yabai -m query --spaces | jq '.[].index'); do
  yabai -m space "$space" --layout float
done
