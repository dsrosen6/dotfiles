#!/usr/bin/env bash

theme="$HOME/.config/rofi/theme.rasi"

if ! pgrep "rofi"; then
    rofi -show drun -theme $theme
else
    killall rofi
fi
