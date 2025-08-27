#!/usr/bin/env bash
current_layout=$(hyprctl getoption general:layout | awk -F': ' '/^str:/ {print $2}')
if [[ "$current_layout" == "dwindle" ]]; then
    hyprctl keyword general:layout "master"
else
    hyprctl keyword general:layout "dwindle"
fi
