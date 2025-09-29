#!/usr/bin/env bash

lock_seconds=300
sleep_seconds=330

lock() {
    if ! pgrep -x swaylock >/dev/null; then
        swaylock -f
    fi
}

export -f lock

swayidle -w \
    timeout $lock_seconds 'bash -c lock' \
    timeout $sleep_seconds 'systemctl suspend' \
    before-sleep 'bash -c lock'
