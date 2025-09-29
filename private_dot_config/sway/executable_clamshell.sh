#!/usr/bin/env bash

if grep -q open /proc/acpi/button/lid/LID/state; then
    echo "lid is open, enabling eDP-1"
    swaymsg output eDP-1 enable
else
    echo "lid is closed, disabling eDP-1"
    swaymsg output eDP-1 disable
fi
