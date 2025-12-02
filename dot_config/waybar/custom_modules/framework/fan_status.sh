#!/bin/bash

speed=$(sensors | awk '/fan1:/{print $2; exit}')

if [ -z "$speed" ] || [ "$speed" = "0" ]; then
	class="low"
elif [ "$speed" -lt 3000 ]; then
	class="low"
elif [ "$speed" -lt 5000 ]; then
	class="medium"
else
	class="high"
fi

echo "{\"text\": \"$speed\", \"class\": \"$class\", \"tooltip\": \"$speed rpm\"}"
