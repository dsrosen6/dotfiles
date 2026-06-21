#!/usr/bin/env bash
# Reinstall explicitly-installed packages from packages.json.
# Repo packages go through pacman; AUR packages through yay.
set -euo pipefail

JSON="${1:-$(dirname "$0")/packages.json}"

if [[ ! -f "$JSON" ]]; then
  echo "error: package list not found: $JSON" >&2
  exit 1
fi

command -v jq >/dev/null || { echo "error: jq is required" >&2; exit 1; }

mapfile -t REPO < <(jq -r '.repo[]' "$JSON")
mapfile -t AUR  < <(jq -r '.aur[]'  "$JSON")

echo ">> Installing ${#REPO[@]} repo packages via pacman..."
sudo pacman -S --needed --noconfirm "${REPO[@]}"

if [[ ${#AUR[@]} -gt 0 ]]; then
  if ! command -v yay >/dev/null; then
    echo ">> yay not found, bootstrapping yay-bin from AUR..."
    sudo pacman -S --needed --noconfirm git base-devel
    tmp="$(mktemp -d)"
    git clone https://aur.archlinux.org/yay-bin.git "$tmp/yay-bin"
    (cd "$tmp/yay-bin" && makepkg -si --noconfirm)
    rm -rf "$tmp"
  fi
  echo ">> Installing ${#AUR[@]} AUR packages via yay..."
  yay -S --needed --noconfirm "${AUR[@]}"
fi

echo ">> Done."
