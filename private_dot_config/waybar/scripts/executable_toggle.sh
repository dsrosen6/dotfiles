#!/usr/bin/env bash

if ! pgrep "waybar"; then
    systemctl --user start waybar.service
else
    systemctl --user stop waybar.service
fi
