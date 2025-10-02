#!/usr/bin/env bash
dconf dump / >/home/danny/.config/gnome-dconf/user-settings.dconf
chezmoi re-add
