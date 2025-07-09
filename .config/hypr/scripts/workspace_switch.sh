#!/bin/bash

WSA=$(hyprctl monitors | grep -A 6 "$MONITOR1" | grep "active workspace" | awk '{print $3}')
WSB=$(hyprctl monitors | grep -A 6 "$MONITOR2" | grep "active workspace" | awk '{print $3}')

WINDOWS=$(hyprctl clients -j)

echo "$WINDOWS" | jq -r ".[] | select(.workspace.id == $WSA) | .address" | while read -r WIN; do
  hyprctl dispatch movetoworkspacesilent "$WSB,address:$WIN"
done

echo "$WINDOWS" | jq -r ".[] | select(.workspace.id == $WSB) | .address" | while read -r WIN; do
  hyprctl dispatch movetoworkspacesilent "$WSA,address:$WIN"
done
