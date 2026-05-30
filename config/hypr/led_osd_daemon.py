#!/usr/bin/env python3
"""
led_osd_daemon.py
Reliable Caps Lock / Num Lock OSD notifier for Hyprland.
Monitors /sys/class/leds/ brightness files and triggers notify-send
(SwayNC notification) only on state change (edge detection).
Volume/Brightness use avizo via volumectl/lightctl.
"""

import os
import sys
import time
import subprocess
import glob

# ======================
# Configuration
# ======================

POLL_INTERVAL = 0.05  # 50ms

LED_PATHS = {
    "capslock": sorted(glob.glob("/sys/class/leds/*::capslock")),
    "numlock": sorted(glob.glob("/sys/class/leds/*::numlock"))
}

ICONS = {
    "capslock": {
        True: "input-keyboard",
        False: "input-keyboard-off"
    },
    "numlock": {
        True: "input-keyboard",
        False: "input-keyboard-off"
    }
}

# ======================
# Helpers
# ======================

def read_led(path):
    """Read 0 or 1 from LED brightness file."""
    try:
        with open(os.path.join(path, "brightness"), "r") as f:
            return f.read().strip() == "1"
    except Exception:
        return False


def send_notification(name, state):
    """Send notification via notify-send (SwayNC)."""
    label = name.replace("lock", " Lock").title()
    status = "ON" if state else "OFF"
    
    # Urgency: normal for ON, low for OFF
    urgency = "normal" if state else "low"
    
    # Icon from Nerd Font fallback via Freedesktop name
    icon = ICONS[name][state]
    
    try:
        subprocess.run(
            [
                "notify-send",
                "-u", urgency,
                "-i", icon,
                "-t", "2000",
                f"{label}",
                f"Status: <b>{status}</b>",
            ],
            capture_output=True,
            timeout=3,
        )
    except Exception as e:
        print(f"[led-osd] notify-send failed: {e}", file=sys.stderr)


def find_first_led(paths):
    """Return the first existing LED path, or None."""
    for p in paths:
        if os.path.exists(os.path.join(p, "brightness")):
            return p
    return None


# ======================
# Main Loop
# ======================

def main():
    print("[led-osd] Starting LED state monitor daemon...")

    leds = {}
    for name, paths in LED_PATHS.items():
        path = find_first_led(paths)
        if path:
            leds[name] = {
                "path": path,
                "state": read_led(path),
            }
            print(f"[led-osd] Monitoring {name}: {path} (initial={leds[name]['state']})")
        else:
            print(f"[led-osd] WARNING: No {name} LED found, skipping.")

    if not leds:
        print("[led-osd] ERROR: No LED devices found. Exiting.")
        sys.exit(1)

    try:
        while True:
            for name, info in leds.items():
                current = read_led(info["path"])
                if current != info["state"]:
                    info["state"] = current
                    send_notification(name, current)
            time.sleep(POLL_INTERVAL)
    except KeyboardInterrupt:
        print("\n[led-osd] Shutting down gracefully.")


if __name__ == "__main__":
    main()
