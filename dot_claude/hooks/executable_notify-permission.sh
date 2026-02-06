#!/bin/bash
input=$(cat)
tool=$(echo "$input" | jq -r '.tool_name // "unknown"')
cwd=$(echo "$input" | jq -r '.cwd // "unknown"')
dir=$(basename "$cwd")

body="approve $tool"

action=$(notify-send --app-name=claude --urgency="low" \
  --action=approve=Approve \
  "claude [$dir]" "$body" 2>/dev/null || true)

if [ "$action" = "approve" ]; then
  printf '{"hookSpecificOutput":{"hookEventName":"PermissionRequest","decision":{"behavior":"allow"}}}'
fi

exit 0
