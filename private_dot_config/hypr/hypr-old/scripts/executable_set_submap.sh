#!/usr/bin/env bash

SUBMAP="$1"
LABEL="$2"
ICON="preferences-desktop-keyboard"

if [[ "$SUBMAP" == "reset" ]]; then
    hyprctl dispatch submap reset && swayosd-client --custom-message "Submap: Default" --custom-icon "$ICON"
    exit 0
fi

hyprctl dispatch submap "$SUBMAP"
if [[ -n "$LABEL" ]]; then
    swayosd-client --custom-message "Submap: $LABEL" --custom-icon "$ICON"
fi
