#!/usr/bin/env bash

seconds_to_wait=15

if pidof hyprlock; then
    echo "hyprlock is already active"
    exit 0
fi

echo "running hyprlock"
nohup hyprlock 2>&1 &

i=$seconds_to_wait
while (($i > 0)); do
    if pidof hyprlock >/dev/null; then
        echo "hyprlock is active; waiting $i more seconds before susending"
        sleep 1 && ((i--))
    else
        echo "hyprlock is no longer active; no action required"
        exit 0
    fi
done

echo "reached end of countdown, suspending device"
systemctl suspend
