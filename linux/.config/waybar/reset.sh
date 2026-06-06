#!/usr/bin/env bash

if pgrep waybar; then
    systemctl --user restart waybar.service
fi
