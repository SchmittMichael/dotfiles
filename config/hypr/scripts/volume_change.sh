#!/bin/bash

set -e

ICONS_DIR="$HOME/.config/hypr/icons"

AUDIO_OUT="@DEFAULT_AUDIO_SINK@"
STEP_SIZE=2

usage() {
  echo "Usage: $(basename "$0") {up|down|toggle|--help|-h}"
}

notify_user() {
  local wpctl_out icon text

  wpctl_out=$(wpctl get-volume $AUDIO_OUT)
  volume_value=$(echo "$wpctl_out" | awk '{printf("%d\n", $2 * 100)}')

  if echo "$wpctl_out" | grep -q "MUTED"; then
    text="Muted ($volume_value%)"
    icon="$ICONS_DIR/volume_muted.png"
  else
    text="$volume_value%"

    if (("$volume_value" == 0)); then
      icon="$ICONS_DIR/volume_muted.png"
    elif (("$volume_value" <= 33)); then
      icon="$ICONS_DIR/volume_low.png"
    elif (("$volume_value" <= 66)); then
      icon="$ICONS_DIR/volume_mid.png"
    else
      icon="$ICONS_DIR/volume_high.png"
    fi
  fi

  notify-send -e \
    -h string:x-canonical-private-synchronous:osd \
    -h int:value:"$volume_value" \
    -u low \
    -i "$icon" \
    "Volume" "$text"
}

case "$1" in
  up)
    wpctl set-volume -l 1 "$AUDIO_OUT" "$STEP_SIZE%+"
    ;;
  down)
    wpctl set-volume "$AUDIO_OUT" "$STEP_SIZE%-"
    ;;
  toggle)
    wpctl set-mute "$AUDIO_OUT" toggle
    ;;
  --help | -h)
    usage
    exit 0
    ;;
  '')
    echo "Missing option"
    usage
    exit 1
    ;;
  *)
    echo "Unkown command '$1'"
    usage
    exit 1
    ;;
esac

notify_user
