#!/bin/bash

set -e

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

SCREENSHOT_DIR="$HOME/Pictures/screenshots"
SCREENSHOT_PATH="$SCREENSHOT_DIR/screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"

if [[ "$#" != 1 ]]; then
  echo "Missing subcommand 'active', 'screen' or 'area'" >&2
  exit 1
fi

if [[ "$1" == "--help" ]]; then
  echo "Usage: $(basename "$0") [active|screen|area]"
  exit 0
fi

if [[ "$1" != "active" && "$1" != "screen" && "$1" != "area" ]]; then
  echo "Invalid argmument. '$1'" >&2
  exit 1
fi

"$SCRIPT_DIR/grimblast.sh" --notify --freeze --annotate copysave "$1" "$SCREENSHOT_PATH"
# "$SCRIPT_DIR/grimblast.sh" --notify --freeze copysave "$1" "$SCREENSHOT_PATH"
