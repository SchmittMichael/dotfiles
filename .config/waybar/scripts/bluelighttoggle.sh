#!/bin/bash

TEMPERATURE=4000
STATE_DIR="$HOME/.local/state/bluelighttoggle"
STATE_FILE="$STATE_DIR/ACTIVE"
PID=$(pgrep -x hyprsunset)

get_info() {
  local alt tooltip

  if [ -z "$PID" ]; then
    tooltip="Enable nightlight"
    alt="disabled"
  else
    tooltip="Disable nightlight"
    alt="enabled"
  fi

  printf '{"alt": "%s", "tooltip": "%s"}' "$alt" "$tooltip"
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
