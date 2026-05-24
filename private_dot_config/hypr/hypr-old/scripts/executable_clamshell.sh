#!/usr/bin/env bash

MONITOR_NAME="eDP-1"
MONITOR_SETTINGS="1920x1200,3440x0,1.25"
TOTAL_MONITORS=$(hyprctl monitors -j | jq length)
SLEEP_CMD="systemctl suspend"

only_1_mtr() {
    if [[ "$TOTAL_MONITORS" -eq 1 ]]; then
        return 0
    else
        return 1
    fi
}

laptop_mtr_enabled() {
    if hyprctl monitors | grep -q "$MONITOR_NAME"; then
        return 0
    else
        return 1
    fi
}

reload_waybar() {
    if pgrep waybar; then
        systemctl --user restart waybar.service && echo "waybar reloaded"
    fi
}

enable_monitor() {
    if laptop_mtr_enabled; then
        echo "$MONITOR_NAME is already enabled"
    else
        hyprctl keyword monitor "$MONITOR_NAME,$MONITOR_SETTINGS" >/dev/null && echo "$MONITOR_NAME enabled"
        reload_waybar
    fi
}

disable_monitor() {
    if hyprctl monitors | grep -q "$MONITOR_NAME"; then
        if only_1_mtr; then
            echo "can't disable the only monitor"
            return 1
        else
            hyprctl keyword monitor "$MONITOR_NAME,disable" >/dev/null && echo "laptop monitor disabled"
            reload_waybar
            return 0
        fi
    else
        echo "$MONITOR_NAME is already disabled"
        return 0
    fi
}

detect_and_set() {
    lid_state=$(cat /proc/acpi/button/lid/LID/state)
    if grep -q "closed" <<<"$lid_state"; then
        disable_monitor
    elif grep -q "open" <<<"$lid_state"; then
        enable_monitor
    else
        echo "unknown lid state"
    fi
}

if [[ "$1" == "off" ]]; then
    disable_monitor
elif [[ "$1" == "on" ]]; then
    enable_monitor
elif [[ "$1" == "detect" ]]; then
    detect_and_set
elif [[ "$1" == "" ]]; then
    echo "no argument provided"
    exit 1
else
    echo "unknown argument: $1"
    exit 1
fi
