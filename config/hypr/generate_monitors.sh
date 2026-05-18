#!/usr/bin/env bash
OUTPUT_FILE="/tmp/hypr_dynamic.conf"
LID_STATE_FILE="/proc/acpi/button/lid/LID0/state"

HDMI_CONNECTED=false
if hyprctl monitors all | grep -q "HDMI-A-1"; then
    HDMI_CONNECTED=true
fi

LID_CLOSED=false
if [[ -f "$LID_STATE_FILE" ]]; then
    grep -q "closed" "$LID_STATE_FILE" && LID_CLOSED=true
fi

MODE="${1:-auto}"

if [[ "$MODE" == "auto" ]]; then
    if $HDMI_CONNECTED && $LID_CLOSED; then
        MODE="external"
    elif $HDMI_CONNECTED && ! $LID_CLOSED; then
        MODE="extend"
    else
        MODE="laptop"
    fi
fi

case "$MODE" in
    laptop)
        cat > "$OUTPUT_FILE" <<'CONF'
monitor=eDP-1,preferred,auto,1
monitor=HDMI-A-1,disable

workspace=1,monitor:eDP-1
workspace=2,monitor:eDP-1
workspace=3,monitor:eDP-1
workspace=4,monitor:eDP-1
workspace=5,monitor:eDP-1
workspace=6,monitor:eDP-1
workspace=7,monitor:eDP-1
workspace=8,monitor:eDP-1
workspace=9,monitor:eDP-1
workspace=10,monitor:eDP-1
CONF
        ;;
    external)
        cat > "$OUTPUT_FILE" <<'CONF'
monitor=eDP-1,disable
monitor=HDMI-A-1,highrr,auto,1

workspace=1,monitor:HDMI-A-1
workspace=2,monitor:HDMI-A-1
workspace=3,monitor:HDMI-A-1
workspace=4,monitor:HDMI-A-1
workspace=5,monitor:HDMI-A-1
workspace=6,monitor:HDMI-A-1
workspace=7,monitor:HDMI-A-1
workspace=8,monitor:HDMI-A-1
workspace=9,monitor:HDMI-A-1
workspace=10,monitor:HDMI-A-1
CONF
        ;;
    extend)
        cat > "$OUTPUT_FILE" <<'CONF'
monitor=eDP-1,preferred,auto,1
monitor=HDMI-A-1,highrr,auto,1

workspace=1,monitor:eDP-1
workspace=2,monitor:eDP-1
workspace=3,monitor:eDP-1
workspace=4,monitor:eDP-1
workspace=5,monitor:eDP-1
workspace=6,monitor:HDMI-A-1
workspace=7,monitor:HDMI-A-1
workspace=8,monitor:HDMI-A-1
workspace=9,monitor:HDMI-A-1
workspace=10,monitor:HDMI-A-1
CONF
        ;;
    mirror)
        cat > "$OUTPUT_FILE" <<'CONF'
monitor=eDP-1,preferred,auto,1
monitor=HDMI-A-1,preferred,auto,1,mirror,eDP-1

workspace=1,monitor:eDP-1
workspace=2,monitor:eDP-1
workspace=3,monitor:eDP-1
workspace=4,monitor:eDP-1
workspace=5,monitor:eDP-1
workspace=6,monitor:eDP-1
workspace=7,monitor:eDP-1
workspace=8,monitor:eDP-1
workspace=9,monitor:eDP-1
workspace=10,monitor:eDP-1
CONF
        ;;
    *)
        echo "[generate_monitors] Unknown mode: $MODE" >&2
        exit 1
        ;;
esac
