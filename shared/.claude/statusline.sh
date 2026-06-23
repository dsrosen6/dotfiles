#!/usr/bin/env bash
input=$(cat)

# Extract fields using jq
MODEL=$(echo "$input" | jq -r '.model.display_name')
DIR=$(echo "$input" | jq -r '.workspace.current_dir')
# The "// 0" provides a fallback if the field is null
CTX=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
USAGE_5H=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // 0' | cut -d. -f1)
USAGE_7D=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // 0' | cut -d. -f1)
RESETS_AT_5H=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at')
RESETS_AT_5H_FMT=$(date -r "$RESETS_AT_5H" "+%I:%M %p" 2>/dev/null)

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

CTX_C=$(color_pct "$CTX")
USAGE_5H_C=$(color_pct "$USAGE_5H")
USAGE_7D_C=$(color_pct "$USAGE_7D")

# Output the status line - ${DIR##*/} extracts just the folder name
echo "[$MODEL] 📁 ${DIR##*/} | CTX ${CTX_C} | 5H USAGE ${USAGE_5H_C} (resets ${RESETS_AT_5H_FMT}) | 7D USAGE ${USAGE_7D_C}"
