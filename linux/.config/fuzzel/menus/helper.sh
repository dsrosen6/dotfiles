#!/usr/bin/env bash

run_menu() {
    local choices="$1"
    local choice=$(echo "$choices" | fuzzel -d)
    echo "$choice"
}

nvim_open() {
    local path="$1"
    local cmd="nvim ${path}"
    uwsm-app -- ghostty -e sh -c "$cmd"
}
