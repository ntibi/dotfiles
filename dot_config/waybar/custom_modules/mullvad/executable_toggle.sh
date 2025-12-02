#!/bin/bash

status=$(mullvad status -j 2>/dev/null)

if [ -z "$status" ]; then
	exit 1
fi

state=$(echo "$status" | jq -r '.state')

if [ "$state" = "connected" ]; then
	mullvad disconnect
else
	mullvad connect
fi
