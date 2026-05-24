#!/usr/bin/env bash

SCRIPTS_DIR="$HOME/.config/rofi/scripts"

clipboard() {
    cliphist list |
        rofi -dmenu -display-columns 2 -i |
        cliphist decode | wl-copy
}

powermenu() {
    choices=$(printf "Lock\nSleep\nLog Out\nReboot\nShut Down")
    choice=$(echo "$choices" | rofi -dmenu -i)
    case $choice in
    "Lock") loginctl lock-session ;;
    "Sleep") systemctl suspend ;;
    "Log Out") hyprctl dispatch exit ;;
    "Reboot") reboot ;;
    "Shut Down") shutdown now ;;
    esac
}

switch_args() {
    case "$1" in
    "clipboard") clipboard ;;
    "power") powermenu ;;
    *) rofi -show drun -run-command "uwsm-app -- {cmd}" ;;
    esac
}

# If rofi is open, kill; else switch on first arg
pkill rofi || switch_args $1
