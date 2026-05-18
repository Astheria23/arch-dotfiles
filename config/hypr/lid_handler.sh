#!/usr/bin/env bash

if hyprctl monitors | grep -q "HDMI-A-1"; then
    ~/.config/hypr/generate_monitors.sh
    hyprctl reload
else
    if [[ $1 == "close" ]]; then
        hyprctl dispatch dpms off eDP-1
    else
        hyprctl dispatch dpms on eDP-1
    fi
fi
