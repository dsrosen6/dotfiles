#!/usr/bin/env bash
choices="Sleep\nLog Out\nReboot\nShut Down"
option=$(echo -e "$choices" | walker --dmenu --hideqa --maxheight 200)

case "$option" in
"Sleep") systemctl suspend ;;
"Log Out") hyprctl dispatch exit ;;
"Reboot") reboot ;;
"Shut Down") shutdown now ;;
*) exit 1 ;;
esac
