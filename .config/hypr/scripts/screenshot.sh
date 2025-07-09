#!/bin/bash

set -e

SCREENSHOT_DIR="$HOME/Pictures/screenshots"
SCREENSHOT_PATH="$SCREENSHOT_DIR/screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"

if [ -d "$SCREENSHOT_DIR" ]; then
  mkdir -p "$SCREENSHOT_DIR"
fi

if [[ "$1" != "active" && "$1" != "screen" && "$1" != "area" ]]; then
  notify-send "ARGUMENT: $1"
  echo "Invalid argmument!"
  exit 1
fi

grimblast --notify copysave "$1" "$SCREENSHOT_PATH"
