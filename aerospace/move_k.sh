
#!/bin/bash

# # Move the focused window to the next monitor and focus it
aerospace move-node-to-monitor --focus-follows-window prev
#
# # Wait a tiny moment to ensure the move completes
sleep 0.05

# Make it fullscreen (in AeroSpace terms)
yabai -m window --grid 1:9:1:0:7:1
# Your custom command goes here
echo "Window moved, fullscreened, and this is a custom action" >> ~/aerospace.log
