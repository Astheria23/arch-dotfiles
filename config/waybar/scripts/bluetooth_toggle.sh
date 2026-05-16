#!/bin/bash
# Bluetooth Toggle for swaync

current_state=$(bluetoothctl show 2>/dev/null | grep "Powered:" | awk '{print $2}')

if [ "$current_state" = "yes" ]; then
    bluetoothctl power off
    notify-send "Bluetooth" "Bluetooth turned off"
else
    bluetoothctl power on
    notify-send "Bluetooth" "Bluetooth turned on"
fi
