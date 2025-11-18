#!/bin/bash

level=$(awk '/^level:/{print $2}' /proc/acpi/ibm/fan)
speed=$(awk '/^speed:/{print $2}' /proc/acpi/ibm/fan)

if [ "$speed" -lt 3000 ]; then
	class="low"
elif [ "$speed" -lt 5000 ]; then
	class="medium"
else
	class="high"
fi

echo "{\"text\": \"$speed\", \"class\": \"$class\", \"tooltip\": \"level: $level\"}"
