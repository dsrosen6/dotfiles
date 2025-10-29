#!/usr/bin/env bash

OUTPUT="eDP-1"
RESOLUTION="1920x1200"
POSITION="auto"
SCALE="1.25"
LID_STATE_FILE="/proc/acpi/button/lid/LID/state"

if rg -Pi "open" $LID_STATE_FILE >/dev/null 2>&1; then
    echo "lid is open, enabling laptop display"
    hyprctl keyword monitor $OUTPUT,$RESOLUTION,$POSITION,$SCALE
elif rg -Pi "closed" $LID_STATE_FILE >/dev/null 2>&1; then
    echo "lid is closed, disabling laptop display"
    hyprctl keyword monitor "$OUTPUT", disable
else
    echo "could not determine lid status"
fi
