#!/usr/bin/env bash
if ! pgrep "rofi"; then
    ~/.config/rofi/launchers/type-2/launcher.sh
else
    killall rofi
fi
