#!/bin/bash
# WiFi Toggle for swaync

current_state=$(nmcli radio wifi 2>/dev/null)

if [ "$current_state" = "enabled" ]; then
    nmcli radio wifi off
    notify-send "WiFi" "WiFi turned off"
else
    nmcli radio wifi on
    notify-send "WiFi" "WiFi turned on"
fi
