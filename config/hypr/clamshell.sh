#!/usr/bin/env bash

MONITOR_COUNT=$(hyprctl monitors | grep -c "Monitor")

if [[ $MONITOR_COUNT -gt 1 ]]; then
    hyprctl keyword monitor "eDP-1, disable"
fi
