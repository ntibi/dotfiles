#!/bin/bash

EMPTY_SYMBOL="○"
FILLED_SYMBOL="●"

print_status() {
    windows=$(niri msg --json windows 2>/dev/null)
    [ -z "$windows" ] && return

    focused=$(echo "$windows" | jq -r '.[] | select(.is_focused == true)')
    [ -z "$focused" ] && echo "" && return

    workspace_id=$(echo "$focused" | jq -r '.workspace_id')
    focused_col=$(echo "$focused" | jq -r '.layout.pos_in_scrolling_layout[0] // empty')

    workspace_windows=$(echo "$windows" | jq -r "[.[] | select(.workspace_id == $workspace_id and .is_floating == false)]")
    columns=$(echo "$workspace_windows" | jq -r '[.[].layout.pos_in_scrolling_layout[0]] | unique | sort | .[]')
    total=$(echo "$columns" | wc -l)

    output=""
    for col in $columns; do
        if [ ! -z "$focused_col" ] && [ "$col" -eq "$focused_col" ]; then
            output+="$FILLED_SYMBOL"
        else
            output+="$EMPTY_SYMBOL"
        fi
    done

    echo "$output"
}

print_status

niri msg --json event-stream 2>/dev/null | while read -r event; do
    event_type=$(echo "$event" | jq -r 'keys[0]')
    case "$event_type" in
        WindowOpenedOrChanged|WindowClosed|WindowsChanged|WindowFocusChanged|WindowLayoutsChanged)
            print_status
            ;;
    esac
done
