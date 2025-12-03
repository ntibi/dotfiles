#!/bin/bash

app_id="scratchpad"

if niri msg --json focused-window | jq -r .app_id | grep "^$app_id$"; then
    niri msg action close-window
elif niri msg --json windows | jq -r ".[] | .app_id" | grep "^$app_id$"; then
    niri msg action close-window --id "$(niri msg --json windows | jq -r ".[] | select(.app_id==\"$app_id\") | .id")"
    niri msg action spawn -- alacritty --class "$app_id" -e vi ~/TODO
else
    niri msg action spawn -- alacritty --class "$app_id" -e vi ~/TODO
fi
