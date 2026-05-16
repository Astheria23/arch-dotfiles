#!/bin/bash
# Battery Status Label for swaync

bat_dir=$(ls -d /sys/class/power_supply/BAT* 2>/dev/null | head -1)

if [ -z "$bat_dir" ]; then
    echo "  N/A"
    exit 0
fi

capacity=$(cat "$bat_dir/capacity" 2>/dev/null)
status=$(cat "$bat_dir/status" 2>/dev/null)

if [ "$status" = "Charging" ] || [ "$status" = "Full" ]; then
    echo "  ${capacity}%"
else
    echo "  ${capacity}%"
fi
