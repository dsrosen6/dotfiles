# Hyprlock Sleep Timer

This is a simple script to use in your Hyprland config that executes `hyprlock` and then puts the device to sleep after a specified amount of time.

If `hyprlock` stops running before the countdown ends, it does not put the device to sleep.

## but why tho

I would prefer a manual lock to have a fairly immediate slepe timer instead of waiting the 10 minutes I have set in `hypridle`.

## Usage

The script defaults to a timer of 15 seconds, but you can change this via the variable `seconds_to_wait` in the script.

Once you have the script somewhere, you can add it to your Hyprland config (or replace your existing lock bind) with something like this:

`bind = CONTROL SHIFT, L, exec, ~/path/to/script.sh`
