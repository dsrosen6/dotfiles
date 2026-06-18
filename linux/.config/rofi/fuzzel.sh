#!/usr/bin/env bash

clipboard() {
    cliphist list |
        rofi -dmenu -display-columns 2 -i |
        cliphist decode | wl-copy
}

powermenu() {
    choices=$(printf "Lock\nSleep\nLog Out\nReboot\nShut Down")
    choice=$(echo "$choices" | fuzzel -d)
    case $choice in
    "Lock") loginctl lock-session ;;
    "Sleep") systemctl suspend ;;
    "Log Out") hyprshutdown ;;
    "Reboot") hyprshutdown --post-cmd 'reboot' ;;
    "Shut Down") shutdown now ;;
    esac
}

notimenu() {
    dnd_status=$(swaync-client -D)
    dnd_cmd="swaync-client -dn"
    dnd_label="DND On"
    if [[ "$dnd_status" == "true" ]]; then
        dnd_cmd="swaync-client -df"
        dnd_label="DND Off"
    fi
    echo "$dnd_status"
    echo "$dnd_cmd"
    echo "$dnd_label"

    choices=$(printf "Clear All\n${dnd_label}")
    choice=$(echo "$choices" | fuzzel -d)
    case $choice in
    "Clear All") swaync-client -C ;;
    "$dnd_label") $dnd_cmd ;;
    esac
}

switch_args() {
    case "$1" in
    "clipboard") clipboard ;;
    "power") powermenu ;;
    "noti") notimenu ;;
    *) fuzzel "--launch-prefix=uwsm-app --" ;;
    esac
}

# If rofi is open, kill; else switch on first arg
pkill fuzzel || switch_args $1
