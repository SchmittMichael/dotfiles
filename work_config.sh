#!/bin/bash

set -e

IRRELEVANT_DIRS=(hypr mako swaync waybar wofi)
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IGNORE_FILE="$REPO_DIR/.stow-local-ignore"

printf '/.config/%s\n' "${IRRELEVANT_DIRS[@]}" >"$IGNORE_FILE"

cd "$REPO_DIR"
stow .

rm "$IGNORE_FILE"
