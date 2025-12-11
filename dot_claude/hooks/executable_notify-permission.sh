#!/bin/bash
input=$(cat)
tool=$(echo "$input" | jq -r '.tool_name // "unknown"')
notify-send --urgency=low --expire-time=3000 "Claude" "approve $tool"
exit 0
