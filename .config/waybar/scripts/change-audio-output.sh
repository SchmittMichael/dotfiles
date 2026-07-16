#!/bin/bash

set -euo pipefail

mapfile -t sinks < <(pactl list short sinks | awk '{print $2}')

if [ "${#sinks[@]}" -eq 0 ]; then
  echo "No audio sinks found"
  exit 1
fi

current="$(pactl get-default-sink)"

next="${sinks[0]}"

for i in "${!sinks[@]}"; do
  if [ "${sinks[$i]}" = "$current" ]; then
    next="${sinks[$(((i + 1) % ${#sinks[@]}))]}"
    break
  fi
done

pactl set-default-sink "$next"

pactl list short sink-inputs | awk '{print $1}' | while read -r input; do
  pactl move-sink-input "$input" "$next"
done

name=$(
  pactl --format=json list sinks |
    jq -r --arg cur "$next" '.[] | select(.name == $cur) | .properties."alsa.name"'
)

notify-send -e \
  -h "string:x-canonical-private-synchronous:change_audio" \
  -u low \
  -i audio-speakers-symbolic \
  "Audio changed" "$name"
