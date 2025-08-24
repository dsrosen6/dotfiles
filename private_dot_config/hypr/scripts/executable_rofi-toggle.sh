#!/usr/bin/env bash
if ! pgrep "rofi"; then
    rofi -show drun
else
    killall rofi
fi
