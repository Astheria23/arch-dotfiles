#!/bin/bash
# Audio Output Switcher - uses rofi to select PipeWire/PulseAudio sink

# Get list of sinks with their descriptions
sinks=$(pactl list short sinks | while IFS=$'\t' read -r num name mod state; do
    desc=$(pactl list sinks | grep -A 15 "Name: $name" | grep "Description:" | sed 's/.*Description: //')
    echo "$name|$desc"
done)

# Build rofi menu
options=""
while IFS='|' read -r sink_name sink_desc; do
    current=$(pactl info | grep "Default Sink:" | awk '{print $3}')
    if [ "$sink_name" = "$current" ] || [ "$sink_desc" = "$current" ]; then
        options+=" $sink_desc (Active)\n"
    else
        options+=" $sink_desc\n"
    fi
done <<< "$sinks"

# Show rofi menu
selected=$(echo -e "$options" | rofi -dmenu -p "Audio Output" -selected-row 0)

if [ -z "$selected" ]; then
    exit 0
fi

# Extract sink description from selection
selected_desc=$(echo "$selected" | sed 's/ //;s/ (Active)//')

# Find the matching sink name
while IFS='|' read -r sink_name sink_desc; do
    if [ "$sink_desc" = "$selected_desc" ]; then
        wpctl set-default "$sink_name"
        notify-send "Audio Output" "Switched to: $selected_desc"
        break
    fi
done <<< "$sinks"
