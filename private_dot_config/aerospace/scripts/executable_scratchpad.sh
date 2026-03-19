#!/usr/bin/env bash
scratchpad_ws_id="S"
ws="$(aerospace list-workspaces --focused)"
if [[ "$ws" == "$scratchpad_ws_id" ]]; then
    # switch to the previous workspace
    aerospace workspace-back-and-forth
else
    aerospace workspace "$scratchpad_ws_id"
fi
