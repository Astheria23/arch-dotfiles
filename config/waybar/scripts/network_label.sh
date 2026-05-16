#!/bin/bash
# Network Status Label for swaync

wifi_status=$(nmcli radio wifi 2>/dev/null)

if [ "$wifi_status" != "enabled" ]; then
    echo "󰤮  WiFi Off"
    exit 0
fi

# Get connected SSID
ssid=$(nmcli -t -f active,ssid dev wifi 2>/dev/null | grep '^yes' | cut -d: -f2)

if [ -n "$ssid" ]; then
    signal=$(nmcli -t -f active,signal dev wifi 2>/dev/null | grep '^yes' | cut -d: -f2)
    echo "  $ssid ($signal%)"
else
    echo "󰤮  No Connection"
fi
