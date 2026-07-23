#!/usr/bin/env bash
input=$(cat)

# Extract fields using jq
MODEL_FULL=$(echo "$input" | jq -r '.model.display_name')
MODEL_SHORT=$(echo "$MODEL_FULL" | grep -ioE 'fable|opus|sonnet|haiku' | head -n1)
if [ -n "$MODEL_SHORT" ]; then
    MODEL=$(printf '%s' "$MODEL_SHORT" | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')
else
    MODEL="$MODEL_FULL"
fi
EFFORT=$(echo "$input" | jq -r '.effort.level // empty')
DIR=$(echo "$input" | jq -r '.workspace.current_dir')
# The "// 0" provides a fallback if the field is null
CTX=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
USAGE_5H=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // 0' | cut -d. -f1)
USAGE_7D=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // 0' | cut -d. -f1)
RESETS_AT_5H=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
RESETS_AT_5H_FMT=$([ -n "$RESETS_AT_5H" ] && { date -r "$RESETS_AT_5H" "+%I:%M %p" 2>/dev/null || date -d @"$RESETS_AT_5H" "+%I:%M %p" 2>/dev/null; })
RESETS_AT_7D=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')
RESETS_AT_7D_FMT=$([ -n "$RESETS_AT_7D" ] && { date -r "$RESETS_AT_7D" "+%A" 2>/dev/null || date -d @"$RESETS_AT_7D" "+%A" 2>/dev/null; })

color_pct() {
    local pct=$1
    if [ "$pct" -ge 75 ]; then
        printf '\033[31m%s%%\033[0m' "$pct"
    elif [ "$pct" -ge 50 ]; then
        printf '\033[33m%s%%\033[0m' "$pct"
    else
        printf '%s%%' "$pct"
    fi
}

# Color the effort level on a cool→hot gradient (256-color)
color_effort() {
    case "$1" in
    low) printf '\033[38;5;40m%s\033[0m' "$1" ;;     # green
    medium) printf '\033[38;5;220m%s\033[0m' "$1" ;; # yellow
    high) printf '\033[38;5;208m%s\033[0m' "$1" ;;   # orange
    xhigh) printf '\033[38;5;202m%s\033[0m' "$1" ;;  # red-orange
    max) printf '\033[1;38;5;196m%s\033[0m' "$1" ;;  # bold red
    *) printf '%s' "$1" ;;
    esac
}

CTX_C=$(color_pct "$CTX")
USAGE_5H_C=$(color_pct "$USAGE_5H")
USAGE_7D_C=$(color_pct "$USAGE_7D")
EFFORT_C=$([ -n "$EFFORT" ] && color_effort "$EFFORT")

# Output the status line - ${DIR##*/} extracts just the folder name
echo "[${DIR##*/}] $MODEL${EFFORT_C:+ $EFFORT_C} | CTX ${CTX_C} | 5H ${USAGE_5H_C} (${RESETS_AT_5H_FMT}) | 7D ${USAGE_7D_C} (${RESETS_AT_7D_FMT})"
