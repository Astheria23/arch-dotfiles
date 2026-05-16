#!/usr/bin/env bash

if hyprctl monitors | grep -q "HDMI-A-1"; then
    if [[ $1 == "close" ]]; then
        hyprctl keyword monitor "eDP-1, disable"
    else
        hyprctl keyword monitor "eDP-1, preferred, auto, 1"
    fi
else
    if [[ $1 == "close" ]]; then
        hyprctl dispatch dpms off eDP-1
    else
        hyprctl dispatch dpms on eDP-1
    fi
fi
