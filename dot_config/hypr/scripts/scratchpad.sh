#!/bin/bash

if ! hyprctl clients | grep -q "class: scratchpad"; then
    hyprctl dispatch exec "[workspace special:scratchpad] alacritty --class scratchpad -e vi ~/TODO"
else
    hyprctl dispatch togglespecialworkspace scratchpad
fi
