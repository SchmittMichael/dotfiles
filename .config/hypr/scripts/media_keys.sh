#!/bin/bash

# https://pbs.twimg.com/media/G3-ga2rWsAAhn9R?format=jpg

set -e

STATE_FIlE=/tmp/recent_mpris_player
THUMBNAIL_FILE=/tmp/mpris_thumbnail

PLAYERS=$(playerctl -a metadata --format '{{playerName}} {{status}}')

usage() {
  echo "Usage: $(basename "$0") {play-pause|next|previous|--help|-h}"
}

get_icon() {
  case $1 in
    spotify)
      echo " "
      ;;
    firefox)
      echo "󰈹 "
      ;;
    *)
      echo " "
      ;;
  esac
}

get_art_url() {
  local art_url=$(playerctl -p "$player" metadata mpris:artUrl)

  if [[ "$art_url" == http* ]]; then
    curl -sL "$art_url" -o "$THUMBNAIL_FILE"
    echo "$THUMBNAIL_FILE"
  elif [[ "$art_url" == file* ]]; then
    echo "${art_url#file://}"
  else
    echo "media-optical"
  fi
}

notify_user() {
  local player=$1
  local command=$2

  if [ "$command" == "next" ] || [ "$command" == "previous" ]; then
    sleep 0.1
  fi

  local artist=$(playerctl -p "$player" metadata artist)
  local title=$(playerctl -p "$player" metadata title)
  local icon=$(get_icon "$player")
  local cover_art=$(get_art_url)
  local status=$(playerctl -p "$player" status)

  notify-send -e \
    -h string:x-canonical-private-synchronous:mpris \
    -u low \
    -i "$cover_art" \
    "$icon $title" "$artist ($status)"
}

get_current_player() {
  if echo "$PLAYERS" | grep -q 'Playing'; then
    local player=$(echo "$PLAYERS" | grep 'Playing' | head -n1 | awk '{{print $1}}')
    echo "$player" >"$STATE_FIlE"
    echo "$player"
  elif [[ -f "$STATE_FIlE" ]]; then
    cat "$STATE_FIlE"
  else
    playerctl -l | head -n1
  fi
}

playerctl_wrapper() {
  local command=$1

  if [[ -z "$PLAYERS" ]]; then
    echo "No players running, exiting"
    exit 0
  fi

  local player=$(get_current_player)
  playerctl -p "$player" "$command"
  notify_user "$player" "$command"
}

case $1 in
  play-pause | next | previous)
    playerctl_wrapper "$1"
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
