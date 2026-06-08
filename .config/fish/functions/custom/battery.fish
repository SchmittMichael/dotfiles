function battery --description "Returns current battery percentage"
  set -l ps_dir /sys/class/power_supply
  set -l bat_dirs $ps_dir/BAT*

  if test (count $bat_dirs) -eq 0
      echo "Battery: N/A (no battery detected)"
      return 1
  end

  set -l bat_dir $bat_dirs[1]

  set -l percentage (cat "$bat_dir/capacity")
  set -l bat_status (cat "$bat_dir/status")

  echo "Battery: $percentage% ($bat_status)"
end
