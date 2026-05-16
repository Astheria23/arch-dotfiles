#!/usr/bin/env bash

if pgrep -x "hyprlock" > /dev/null; then
    exit
fi

brightnessctl -s set 10%
hyprlock -c ~/.config/hypr/hyprlock_aod.conf > /dev/null 2>&1
brightnessctl -r
