#!/usr/bin/env bash

if pgrep waybar; then
    systemctl --user stop waybar.service
else
    systemctl --user start waybar.service
fi
