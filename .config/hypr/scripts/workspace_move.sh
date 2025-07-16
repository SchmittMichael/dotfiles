#!/bin/bash

SOURCE_WS=$(hyprctl activeworkspace -j | jq '.id')
TARGET_WS=$1
if [ -z "$TARGET_WS" ]; then
  exit 1
fi

hyprctl clients -j | jq -c ".[] | select(.workspace.id == $SOURCE_WS)" | while read -r window; do
  WID=$(echo "$window" | jq -r '.address')
  hyprctl dispatch movetoworkspace "$TARGET_WS,address:$WID"
done
