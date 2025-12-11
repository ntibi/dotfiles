#!/bin/bash
input=$(cat)
reason=$(echo "$input" | jq -r '.stop_reason // "completed"')
cwd=$(echo "$input" | jq -r '.cwd // "unknown"')
dir=$(basename "$cwd")
notify-send --urgency=low "Claude [$dir]" "task $reason"
exit 0
