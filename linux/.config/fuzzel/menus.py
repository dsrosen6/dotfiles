import subprocess
import os
import argparse


class Choice:
    def __init__(self, label, command):
        self.label = label
        self.command = command
        self.parent: "Menu | None" = None


class Menu(Choice):
    def __init__(self, label, choices: list[Choice]):
        super().__init__(label, self.run_fuzzel)
        self.choices = choices
        self.parent = None
        for choice in self.choices:
            choice.parent = self

    def run_fuzzel(self):
        entries = self.choices
        if self.parent:
            entries = [Choice("Back", self.parent.run_fuzzel)] + entries

        choices_string = "\n".join(
            f"{i + 1} {choice.label}" for i, choice in enumerate(entries)
        )

        result = subprocess.run(
            ["fuzzel", "--dmenu"], input=choices_string, capture_output=True, text=True
        )

        selected = result.stdout.strip()
        if selected:
            index = int(selected.split()[0]) - 1
            command = entries[index].command
            if callable(command):
                command()
            else:
                subprocess.run(command, shell=True)


class DynamicMenu(Menu):
    def __init__(self, label, choices_fn):
        super().__init__(label, [])
        self.choices_fn = choices_fn

    def run_fuzzel(self):
        self.choices = self.choices_fn()
        for choice in self.choices:
            choice.parent = self
        super().run_fuzzel()


def noti_menu_choices():
    dnd_status = subprocess.run(
        ["swaync-client", "-D"], capture_output=True, text=True
    ).stdout.strip()

    if dnd_status == "true":
        dnd_label = "DND Off"
        dnd_cmd = "swaync-client -df"
    else:
        dnd_label = "DND On"
        dnd_cmd = "swaync-client -dn"

    return [
        Choice("Clear All", "swaync-client -C"),
        Choice(dnd_label, dnd_cmd),
    ]


def open_in_ghostty(cmd):
    return f"uwsm-app -- ghostty -e {cmd}"


def nvim_open(path):
    return open_in_ghostty(f"nvim '{path}'")


def cfg_path(path):
    cfg = os.environ.get("XDG_CONFIG_HOME", os.path.expanduser("~/.config"))
    return f"{cfg}/{path}"


def hypr_open(file):
    return nvim_open(cfg_path(f"hypr/hyprland/{file}.lua"))


def waybar_open(file):
    return nvim_open(cfg_path(f"waybar/{file}"))


power_menu = Menu(
    "Power",
    [
        Choice("Lock", "loginctl lock-session"),
        Choice("Sleep", "systemctl suspend"),
        Choice("Log Out", "hyprshutdown"),
        Choice("Reboot", "hyprshutdown --post-cmd 'reboot'"),
        Choice("Shut Down", "shutdown now"),
    ],
)

hypr_menu = Menu(
    "Hyprland",
    [
        Choice("Binds", hypr_open("binds")),
        Choice("Appearance", hypr_open("appearance")),
        Choice("Monitors", hypr_open("monitor")),
    ],
)

waybar_menu = Menu(
    "Waybar",
    [
        Choice("Toggle", "killall -SIGUSR1 waybar"),
        Choice("Config", waybar_open("config.jsonc")),
        Choice("Style", waybar_open("style.css")),
        Choice("Reload", "killall -SIGUSR2 waybar"),
    ],
)

clipboard_cmd = "cliphist list | fuzzel -d --with-nth=2 | cliphist decode | wl-copy"
clipboard_menu_item = Choice("Clipboard", clipboard_cmd)
noti_menu = DynamicMenu("Notifications", noti_menu_choices)
main_menu = Menu(
    "Main Menu", [power_menu, hypr_menu, waybar_menu, noti_menu, clipboard_menu_item]
)

if __name__ == "__main__":
    if subprocess.run(["pkill", "fuzzel"]).returncode == 0:
        exit()

    parser = argparse.ArgumentParser()
    parser.add_argument("mode", nargs="?")
    args = parser.parse_args()

    match args.mode:
        case "clipboard":
            subprocess.run(clipboard_cmd, shell=True)
        case "power":
            power_menu.run_fuzzel()
        case "noti":
            noti_menu.run_fuzzel()
        case "settings":
            main_menu.run_fuzzel()
        case _:
            subprocess.run(["fuzzel", "--launch-prefix=uwsm-app --"])
