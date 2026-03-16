#!/usr/bin/env bash
action="$1"
ws="$(aerospace list-workspaces --focused)"
[ -z "$ws" ] && exit 0

windows=$(aerospace list-windows --workspace "$ws" --json)
echo "$windows" | jq -r '.[].["window-id"]' | while read -r window_id; do
    aerospace layout --window-id "$window_id" "$action" 2>/dev/null || true
done
