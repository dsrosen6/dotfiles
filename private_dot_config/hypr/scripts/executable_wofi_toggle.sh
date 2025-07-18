#!/bin/bash

# if wofi is running, exit it, else show it
# this provides a macOS spotlight-esque "toggle" when run with a keybind
#pgrep wofi >/dev/null 2>&1 && killall wofi || uwsm app -- "$(wofi --show drun --define=drun-print_desktop_file=true | sed -E "s/(\.desktop) /\1:/")" 
uwsm app -- "$(wofi --show drun --define=drun-print_desktop_file=true | sed -E "s/(\.desktop) /\1:/")"
