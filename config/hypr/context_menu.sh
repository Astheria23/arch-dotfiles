#!/usr/bin/env bash
# Hyprland Context Menu
# Theme: Catppuccin Mocha
# Trigger: Super+grave (backtick)

set -euo pipefail

# Get cursor position from Hyprland
CURSOR_POS=$(hyprctl cursorpos 2>/dev/null || echo "0,0")
X_POS=$(echo "$CURSOR_POS" | cut -d',' -f1 | tr -d ' ')
Y_POS=$(echo "$CURSOR_POS" | cut -d',' -f2 | tr -d ' ')

# Menu entries with icons (Nerd Font)
MENU=$(cat <<'EOF'
  Terminal
  File Manager
  Browser
  Wallpaper
  Clipboard
  Settings
  Lock Screen
󰍃  Logout
  Reboot
⏻  Shutdown
EOF
)

# Show menu with wofi at cursor position
# Location 1 = top-left, offset by cursor position minus some padding
SELECTION=$(echo "$MENU" | wofi \
    --dmenu \
    --prompt "Menu" \
    --style ~/.config/wofi/style-menu.css \
    --location 1 \
    --xoffset "$X_POS" \
    --yoffset "$Y_POS" \
    --lines 10 \
    --width 280 \
    --hide-scroll \
    --parse-search \
    2>/dev/null || true)

# Strip icon prefix (everything up to and including two spaces)
SELECTION_CLEAN=$(echo "$SELECTION" | sed 's/^.*  //')

case "$SELECTION_CLEAN" in
    "Terminal")
        kitty &
        ;;
    "File Manager")
        dolphin &
        ;;
    "Browser")
        flatpak run app.zen_browser.zen &
        ;;
    "Wallpaper")
        waypaper &
        ;;
    "Clipboard")
        cliphist list | wofi --dmenu --prompt "Clipboard" --style ~/.config/wofi/style-menu.css | cliphist decode | wl-copy &
        ;;
    "Settings")
        # Try KDE System Settings first, fallback to GNOME Settings
        if command -v systemsettings5 >/dev/null 2>&1; then
            systemsettings5 &
        elif command -v gnome-control-center >/dev/null 2>&1; then
            gnome-control-center &
        else
            notify-send "Settings" "No settings application found"
        fi
        ;;
    "Lock Screen")
        hyprlock &
        ;;
    "Logout")
        hyprctl dispatch exit
        ;;
    "Reboot")
        systemctl reboot
        ;;
    "Shutdown")
        systemctl poweroff
        ;;
    *)
        # No selection or cancelled
        exit 0
        ;;
esac
