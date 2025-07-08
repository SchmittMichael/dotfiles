#!/bin/bash

TEMPERATURE=5000
STATE_DIR="$HOME/.local/state/bluelighttoggle"
STATE_FILE="$STATE_DIR/ACTIVE"
PID=$(pgrep -x hyprsunset)

get_info() {
  if [ -z "$PID" ]; then
    local tooltip="Enable nightlight"
    local icon="󰃞"
  else
    local tooltip="Disable nightlight"
    local icon="󰃝"
  fi

  echo "{\"text\": \"$icon\", \"tooltip\": \"$tooltip\"}"
}

enable_bluelight() {
  hyprsunset -t $TEMPERATURE &
  echo "hyprsunset started with temperature $TEMPERATURE"

  if [ ! -d "$STATE_DIR" ]; then
    mkdir -p "$STATE_DIR"
  fi
  touch "$STATE_FILE"
}

disable_bluelight() {
  kill "$PID"
  echo "hyprsunset stopped"

  if [ -f "$STATE_FILE" ]; then
    rm "$STATE_FILE"
  fi
}

toggle_bluelight() {
  if [ -z "$PID" ]; then
    enable_bluelight
  else
    disable_bluelight
  fi
}

check_on_startup() {
  if [ -f "$STATE_FILE" ]; then
    enable_bluelight
  fi
}

case $1 in
  info)
    get_info
    ;;
  toggle)
    toggle_bluelight
    ;;
  startup)
    check_on_startup
    ;;
  *)
    echo "Unknown option '$1'. Use 'info', 'toggle' or 'startup'."
    ;;
esac
