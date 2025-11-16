#!/bin/bash

level=$(awk '/^level:/{print $2}' /proc/acpi/ibm/fan)
speed=$(awk '/^speed:/{print $2}' /proc/acpi/ibm/fan)

if [ "$speed" -lt 3000 ]; then
	class="low"
elif [ "$speed" -lt 4500 ]; then
	class="medium"
elif [ "$speed" -lt 5500 ]; then
	class="high"
else
	class="full"
fi

echo "{\"text\": \"$speed\", \"class\": \"$class\", \"tooltip\": \"level: $level\"}"
