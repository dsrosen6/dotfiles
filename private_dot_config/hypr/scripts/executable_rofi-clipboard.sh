#!/usr/bin/env bash
if ! pgrep "rofi"; then
    cliphist list | rofi -dmenu | cliphist decode | wl-copy
else
    killall rofi
fi
