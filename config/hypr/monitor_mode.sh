#!/usr/bin/env bash

MODE=$1
HDMI_STATUS=$(hyprctl monitors all | grep -c "HDMI-A-1")

if [[ "$HDMI_STATUS" == "0" && "$MODE" != "laptop" ]]; then
    notify-send "Monitor Error" "HDMI not Detected!"
    exit 1
fi

~/.config/hypr/generate_monitors.sh "$MODE"
hyprctl reload
