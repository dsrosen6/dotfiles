#!/usr/bin/env bash

LAPTOP_OUTPUT=eDP-1
LID_STATE_FILE="/proc/acpi/button/lid/LID/state"

if rg -Pi "open" $LID_STATE_FILE >/dev/null 2>&1; then
    #niri msg output "$LAPTOP_OUTPUT" on
    echo "laptop open"
elif rg -Pi "closed" $LID_STATE_FILE >/dev/null 2>&1; then
    #niri msg output "$LAPTOP_OUTPUT" off
    echo "laptop closed"
else
    echo "could not determine lid status"
fi
