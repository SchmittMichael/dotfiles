#!/bin/bash

set -e

output=$(rocm-smi -d 0 --showuse --showmemuse --showpower --showtemp --json)

use=$(jq -r '.card0["GPU use (%)"]' <<<"$output")
temp=$(jq -r '.card0["Temperature (Sensor edge) (C)"]' <<<"$output")
pwr=$(jq -r '.card0["Average Graphics Package Power (W)"]' <<<"$output")
vram=$(jq -r '.card0["GPU Memory Allocated (VRAM%)"]' <<<"$output")

use_i=$(printf "%.0f%%" "$use")
temp_i=$(printf "%.0f°C" "$temp")
pwr_i=$(printf "%.0f W" "$pwr")
vram_i=$(printf "%.0f%%" "$vram")

tooltip=$(printf "Load:\t%s\nTemp:\t%s\nPower:\t%s\nVRAM:\t%s" "$use_i" "$temp_i" "$pwr_i" "$vram_i")

jq -nMc \
  --arg text "${use_i}" \
  --arg tooltip "$tooltip" \
  --arg alt "none" \
  --arg class "none" \
  '{text:$text, tooltip:$tooltip, alt:$alt, class:$class}'
