#!/bin/bash

if systemctl --user is-active --quiet hypridle; then
    echo '{"text": "󰌾", "tooltip": "hypridle enabled", "class": "enabled"}'
else
    echo '{"text": "󰌿", "tooltip": "hypridle disabled", "class": "disabled"}'
fi
