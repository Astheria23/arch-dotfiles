#!/usr/bin/env bash

help_text="HYPRLAND KEYBINDS HELP
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NAVIGATION
  Super+Ctrl+H          Move Focus Left
  Super+Ctrl+L          Move Focus Right
  Super+Ctrl+K          Move Focus Up
  Super+Ctrl+J          Move Focus Down
  Alt+Tab               Cycle Windows

WINDOW MANAGEMENT
  Super+Return          Open Terminal
  Super+Q               Kill Active Window
  Super+Space           Toggle Floating
  Super+F               Fullscreen
  Super+Ctrl+F          Fullscreen (Native)
  Super+Shift+H         Resize Left
  Super+Shift+J         Resize Down
  Super+Shift+K         Resize Up
  Super+Shift+L         Resize Right

APPS & LAUNCHER
  Super+R               App Launcher (Rofi)
  Super+B               Open Browser
  Super+E               File Manager
  Super+N               Notification Center
  Super+Shift+W         Wallpaper Picker

WORKSPACE
  Super+1-0             Go to Workspace
  Super+Shift+1-0       Move to Workspace

SYSTEM
  Super+M               Power Menu
  Super+Shift+P         Reload Hyprland
  Super+Ctrl+P          Disable Laptop Display
  Super+Ctrl+A          Always-On Display
  Super+Shift+O         CPU Power Mode
  Super+Alt+1           Monitor: Laptop Only
  Super+Alt+2           Monitor: External Only
  Super+Alt+3           Monitor: Extend
  Super+Alt+4           Monitor: Mirror

CLIPBOARD
  Super+V               Clipboard History
  Super+Shift+V         Clear Clipboard

SCREENSHOT
  Print                 Screenshot Full
  Super+Shift+S         Screenshot Area

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Press Esc to close"

echo "$help_text" | wofi --show dmenu --style ~/.config/wofi/style-keybinds.css --prompt "Search: " --lines 20
