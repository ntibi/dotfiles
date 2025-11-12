#!/bin/bash

status=$(mullvad status -j 2>/dev/null)

if [ -z "$status" ]; then
	echo '{"text": "VPN error", "class": "error", "tooltip": "mullvad not available"}'
	exit 0
fi

state=$(echo "$status" | jq -r '.state')

if [ "$state" = "connected" ]; then
	country=$(echo "$status" | jq -r '.details.location.country // "unknown"')
	city=$(echo "$status" | jq -r '.details.location.city // ""')
	location="${city:+$city, }$country"
	echo "{\"text\": \"VPN up $location\", \"class\": \"connected\", \"tooltip\": \"connected to $location\"}"
else
	echo '{"text": "VPN down", "class": "disconnected", "tooltip": "mullvad disconnected"}'
fi
