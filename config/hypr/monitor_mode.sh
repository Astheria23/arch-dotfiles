#!/usr/bin/env bash

MODE=$1
HDMI_STATUS=$(hyprctl monitors all | grep -c "HDMI-A-1")

if [[ "$HDMI_STATUS" == "0" && "$MODE" != "laptop" ]]; then
    notify-send "Monitor Error" "HDMI not Detected!"
    exit 1
fi

case $MODE in
    "laptop")
        hyprctl keyword monitor "eDP-1, preferred, auto, 1"
        hyprctl keyword monitor "HDMI-A-1, disable"
        ;;
    "external")
        hyprctl keyword monitor "eDP-1, disable"
        hyprctl keyword monitor "HDMI-A-1, highrr, auto, 1"
        ;;
    "extend")
        hyprctl keyword monitor "eDP-1, preferred, auto, 1"
        hyprctl keyword monitor "HDMI-A-1, highrr, auto, 1"
        ;;
    "mirror")
        hyprctl keyword monitor "eDP-1, preferred, auto, 1"
        hyprctl keyword monitor "HDMI-A-1, preferred, auto, 1, mirror, eDP-1"
        ;;
esac
