#!/usr/bin/env bash

STATE_FILE="/tmp/cpu_mode_state"

if [[ ! -f "$STATE_FILE" ]]; then
    echo "easy" > "$STATE_FILE"
fi

CURRENT_STATE=$(cat "$STATE_FILE")

if [[ -n "$1" ]]; then
    NEXT_STATE="$1"
else
    case $CURRENT_STATE in
        "easy")  NEXT_STATE="bring" ;;
        "bring") NEXT_STATE="race" ;;
        "race")  NEXT_STATE="easy" ;;
        *)       NEXT_STATE="bring" ;;
    esac
fi

case $NEXT_STATE in
    "easy")
        sudo cpupower frequency-set -u 2.0GHz
        notify-send -u normal -t 3000 "CPU Profile" "🟢 Easy Mode (2.0 GHz)"
        echo "easy" > "$STATE_FILE"
        ;;
    "bring")
        sudo cpupower frequency-set -u 2.5GHz
        notify-send -u normal -t 3000 "CPU Profile" "🟡 Bring it on mode (2.5 GHz)"
        echo "bring" > "$STATE_FILE"
        ;;
    "race")
        sudo cpupower frequency-set -u 3.4GHz
        notify-send -u normal -t 3000 "CPU Profile" "🔴 Race Mode (3.4 GHz)"
        echo "race" > "$STATE_FILE"
        ;;
esac
