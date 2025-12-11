#!/bin/bash
input=$(cat)
tool=$(echo "$input" | jq -r '.tool_name // "unknown"')
cwd=$(echo "$input" | jq -r '.cwd // "unknown"')
dir=$(basename "$cwd")
notify-send --urgency=low "Claude [$dir]" "approve $tool"
exit 0
