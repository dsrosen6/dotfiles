#!/usr/bin/env bash

seconds_to_wait=15

if pidof swaylock; then
    echo "swaylock is already active"
    exit 0
fi

echo "running swaylock"
nohup swaylock 2>&1 &

i=$seconds_to_wait
while (($i > 0)); do
    if pidof swaylock >/dev/null; then
        echo "swaylock is active; waiting $i more seconds before susending"
        sleep 1 && ((i--))
    else
        echo "swaylock is no longer active; no action required"
        exit 0
    fi
done

echo "reached end of countdown, suspending device"
systemctl suspend
