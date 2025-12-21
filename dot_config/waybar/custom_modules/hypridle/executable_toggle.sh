#!/bin/bash

if systemctl --user is-active --quiet hypridle; then
    systemctl --user stop hypridle
else
    systemctl --user start hypridle
fi
