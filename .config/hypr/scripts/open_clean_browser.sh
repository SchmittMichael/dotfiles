#!/bin/bash

set -ex

MAIN_WORKSPACE=9
SECONDARY_WORKSPACE=10

get_broswer() {
  local desktop_file
  local desktop_path

  desktop_file=$(xdg-settings get default-web-browser) || exit 1
  desktop_path=$(find ~/.local/share/applications /usr/share/applications -name "$desktop_file" | head -n 1) || exit 1

  grep -m1 '^Exec=' "$desktop_path" | sed 's/^Exec=//' | awk '{print $1}'
}

hyprctl dispatch focusmonitor "$MONITOR2"
hyprctl dispatch workspace "$SECONDARY_WORKSPACE"
hyprctl dispatch focusmonitor "$MONITOR1"
hyprctl dispatch workspace "$MAIN_WORKSPACE"

# Sanity check to ensure right workspace has been selected
while [ "$(hyprctl activeworkspace -j | jq .id)" != "$MAIN_WORKSPACE" ]; do
  sleep 0.1
done

if hyprctl monitors -j | jq ".[].specialWorkspace.name" | grep -q special:magic; then
  hyprctl dispatch togglespecialworkspace magic
fi

hyprctl dispatch exec "[workspace $MAIN_WORKSPACE] $(get_broswer)"
