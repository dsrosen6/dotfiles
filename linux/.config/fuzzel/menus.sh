#!/usr/bin/env bash
source "$XDG_CONFIG_HOME/fuzzel/menus/helper.sh"

clipboard() {
    cliphist list | fuzzel -d --with-nth=2 | cliphist decode | wl-copy
}

power_menu() {
    local choices=(
        "1 Lock"
        "2 Sleep"
        "3 Log Out"
        "4 Reboot"
        "5 Shut Down"
    )
    choices=$(printf '%s\n' "${choices[@]}")
    local choice=$(run_menu "$choices")
    case $choice in
    "1 Lock") loginctl lock-session ;;
    "2 Sleep") systemctl suspend ;;
    "3 Log Out") hyprshutdown ;;
    "4 Reboot") hyprshutdown --post-cmd 'reboot' ;;
    "5 Shut Down") shutdown now ;;
    esac
}

noti_menu() {
    dnd_status=$(swaync-client -D)
    dnd_cmd="swaync-client -dn"
    dnd_label="DND On"
    if [[ "$dnd_status" == "true" ]]; then
        dnd_cmd="swaync-client -df"
        dnd_label="DND Off"
    fi
    echo "$dnd_status"
    echo "$dnd_cmd"
    echo "$dnd_label"

    local choices=$(printf "Clear All\n${dnd_label}")
    local choice=$(run_menu "$choices")
    case $choice in
    "Clear All") swaync-client -C ;;
    "$dnd_label") $dnd_cmd ;;
    esac
}

hypr_menu() {
    local choices=(
        "1 Binds"
        "2 Appearance"
        "3 Monitors"
    )
    choices=$(printf '%s\n' "${choices[@]}")
    choice=$(run_menu "$choices")
    case "$choice" in
    "1 Binds") nvim_open "$XDG_CONFIG_HOME/hypr/hyprland/binds.lua" ;;
    "2 Appearance") nvim_open "$XDG_CONFIG_HOME/hypr/hyprland/appearance.lua" ;;
    "3 Binds") nvim_open "$XDG_CONFIG_HOME/hypr/hyprland/monitor.lua" ;;
    esac
}

waybar_menu() {
    local choices=(
        "1 Toggle"
        "2 Config"
        "3 Style"
        "4 Reload"
    )
    choices=$(printf '%s\n' "${choices[@]}")
    choice=$(run_menu "$choices")
    case "$choice" in
    "1 Toggle") killall -SIGUSR1 waybar ;;
    "2 Config") nvim_open "$XDG_CONFIG_HOME/waybar/config.jsonc" ;;
    "3 Style") nvim_open "$XDG_CONFIG_HOME/waybar/style.css" ;;
    "4 Reload") killall -SIGUSR2 waybar ;;
    esac
}

#######################################################################
##### Main Menu #######################################################
#######################################################################
main_menu() {
    local choices=(
        "1 Power"
        "2 Hyprland"
        "3 Notifications"
        "4 Waybar"
    )
    choices=$(printf '%s\n' "${choices[@]}")
    choice=$(run_menu "$choices")
    case "$choice" in
    "1 Power") power_menu ;;
    "2 Hyprland") hypr_menu ;;
    "3 Notifications") noti_menu ;;
    "4 Waybar") waybar_menu ;;
    esac
}

switch_args() {
    case "$1" in
    "clipboard") clipboard ;;
    "power") power_menu ;;
    "noti") noti_menu ;;
    "settings") main_menu ;;
    *) fuzzel "--launch-prefix=uwsm-app --" ;;
    esac
}

# If fuzzel is open, kill; else switch on first arg
pkill fuzzel || switch_args $1
