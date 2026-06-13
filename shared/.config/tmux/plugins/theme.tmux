#!/usr/bin/env bash

# Colors - TokyoNight Moon
bg="#222436"
fg="#545c7e"
fg_current="#c8d3f5"
fg_session="#636da6"
fg_prefix="#4fd6be"

# Session component (rounded, prefix highlight)
session_text=" #S "
session_text_inner="#S"
edge_left=''
edge_right=''
session_component="#[bg=$bg,fg=$fg_session]#{?client_prefix,#[fg=$fg_prefix]$edge_left,$session_text}#[bg=$fg_prefix,fg=$bg,nobold]#{?client_prefix,$session_text_inner,}#[bg=$bg,fg=${fg_session}]#{?client_prefix,#[fg=$fg_prefix]$edge_right,}"

# Window format & SSH
base_window_format=' #W '
ssh_icon='󰌘'
ssh_window_format=" ${ssh_icon} #(host=\$(echo '#{pane_title}' | sed 's/^ssh //; s/ .*//; s/.*@//; s/:.*//'); if echo \"\$host\" | grep -qE '^[0-9.]+\$|^[0-9]'; then echo '#W'; else echo \"\$host\"; fi | cut -c1-20) "
window_status_format="#{?#{==:#{pane_current_command},ssh},${ssh_window_format},${base_window_format}}"

maximized_pane_icon='󰊓'

# Apply
tmux set-option -g status-position "bottom"
tmux set-option -g status-justify "absolute-centre"
tmux set-option -g status-left "$session_component"
tmux set-option -g status-right ""
tmux set-window-option -g window-status-separator ' • '
tmux set-option -g window-status-style "bg=${bg},fg=${fg}"
tmux set-option -g window-status-format "$window_status_format"
tmux set-option -g status-style "bg=${bg},fg=${fg}"
tmux set-option -g window-status-bell-style "bg=${fg_prefix},fg=${bg},bold"
tmux set-option -g window-status-activity-style "bg=${fg_current},fg=${bg}"

current_format="#[bg=${bg},fg=${fg_current}]${window_status_format}#[fg=#86e1fc,bg=${bg}]#{?window_zoomed_flag,${maximized_pane_icon},}#[fg=${bg},bg=default]"
tmux set-option -g window-status-current-format "$current_format"
