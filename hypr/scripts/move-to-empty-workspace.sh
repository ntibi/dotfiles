#!/bin/bash

workspaces=$(hyprctl workspaces -j | jq -r '.[].id' | sort -n)

start_at=$(( $(echo "$workspaces" | tail -n 1) + 1 ))

for i in $(seq "$start_at" $((start_at + 10))); do
    if ! echo "$workspaces" | grep -q "^${i}$"; then
        hyprctl dispatch movetoworkspace "$i"
        exit 0
    fi
done

echo "no empty workspace found"
exit 1
