#!/bin/bash
input=$(cat)
tool=$(echo "$input" | jq -r '.tool_name // "unknown"')
notify-send --urgency=low "Claude" "approve $tool"
exit 0
