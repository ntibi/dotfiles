#!/bin/bash
input=$(cat)
reason=$(echo "$input" | jq -r '.stop_reason // "completed"')
notify-send --urgency=low "Claude" "task $reason"
exit 0
