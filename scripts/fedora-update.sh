#!/usr/bin/env bash

update_dnf() {
    sudo dnf upgrade -y && echo "dnf updates finished"
}

update_flatpak() {
    flatpak update -y && echo "flatpak updates finished"
}

fails=0
update_dnf || ((fails++))
update_flatpak || ((fails++))

if [[ "$fails" -eq 0 ]]; then
    echo "Updates successful"
    exit 0
fi

echo "One or more failure occurred"
exit 1
