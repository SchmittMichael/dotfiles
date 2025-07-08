#!/bin/bash

WSA=$(hyprctl monitors | grep -A 6 "$MONITOR1" | grep "active workspace" | awk '{print $3}')
WSB=$(hyprctl monitors | grep -A 6 "$MONITOR2" | grep "active workspace" | awk '{print $3}')

WINDOWS=$(hyprctl clients -j)

# Move windows from WS1 to WS2
echo "$WINDOWS" | jq -r ".[] | select(.workspace.id == $WSA) | .address" | while read -r WIN; do
  hyprctl dispatch movetoworkspacesilent "$WSB,address:$WIN"
done

# Move windows from WS2 to WS1
echo "$WINDOWS" | jq -r ".[] | select(.workspace.id == $WSB) | .address" | while read -r WIN; do
  hyprctl dispatch movetoworkspacesilent "$WSA,address:$WIN"
done
