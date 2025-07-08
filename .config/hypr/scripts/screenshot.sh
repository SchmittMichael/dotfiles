#!/bin/bash

set -e

BASE_PATH="$HOME/Pictures/screenshots"
SCREENSHOT_NAME="$BASE_PATH/screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"



# Ensure screenshot directory exists
mkdir -p "$BASE_PATH"

if [[ "$1" != "active" && "$1" != "screen" && "$1" != "area" ]]; then
  notify-send "ARGUMENT: $1"
  echo "Invalid argmument!"
  exit 1
fi

# notify-send "reached grimblast"

grimblast --notify copysave "$1" "$SCREENSHOT_NAME"
