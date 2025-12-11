#!/bin/bash
input=$(cat)
reason=$(echo "$input" | jq -r '.stop_reason // "completed"')
notify-send --urgency=low --expire-time=3000 "Claude" "task $reason"
exit 0
