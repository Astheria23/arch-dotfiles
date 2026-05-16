#!/usr/bin/env bash

usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
usage_int=${usage%.*}

bars=(" " "▂" "▃" "▄" "▅" "▆" "▇" "█")

idx=$(( usage_int * 8 / 100 ))
[[ $idx -gt 7 ]] && idx=7

echo "${bars[$idx]}"
