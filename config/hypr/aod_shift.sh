#!/usr/bin/env bash

RAND_X=$(shuf -i 1-15 -n 1)
RAND_Y=$(shuf -i 1-6 -n 1)
PAD_X=$(printf '%*s' "$RAND_X" "")
PAD_Y=$(printf '%*s' "$RAND_Y" | tr ' ' '\n')

TIME=$(date +"%H:%M")

echo -e "${PAD_Y}${PAD_X}<span foreground='#555555'>󰣇  Arch Linux\n${PAD_X}   <b>${TIME}</b></span>"
