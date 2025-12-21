#!/bin/bash

if systemctl --user is-active --quiet hypridle; then
    echo '{"text": "<span size=\"large\">󰌾</span>", "tooltip": "hypridle enabled", "class": "enabled"}'
else
    echo '{"text": "<span size=\"large\">󰌿</span>", "tooltip": "hypridle disabled", "class": "disabled"}'
fi
