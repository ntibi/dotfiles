#!/bin/bash

app_id="scratchpad"
magic_workspace="magic"

if niri msg --json focused-window | jq -r .app_id | grep "^$app_id$"; then
    # send to magic workspace
    niri msg action move-window-to-workspace $magic_workspace --focus false
elif niri msg --json windows | jq -r ".[] | .app_id" | grep "^$app_id$"; then
    # bring back from wherever
    id=$(niri msg --json windows | jq -r ".[] | select(.app_id==\"$app_id\") | .id")
    workspace=$(niri msg --json workspaces | jq '.[] | select(.is_focused==true) | .id')
    niri msg action move-window-to-workspace --window-id "$id" --focus true "$workspace"
    niri msg action focus-window --id "$id"
else
    # spawn new
    niri msg action spawn -- alacritty --class "$app_id" -e vi ~/TODO
fi
