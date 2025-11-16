#!/bin/bash

level=$(awk '/^level:/{print $2}' /proc/acpi/ibm/fan)
speed=$(awk '/^speed:/{print $2}' /proc/acpi/ibm/fan)

if [ "$level" = "auto" ]; then
	class="auto"
elif [ "$level" = "disengaged" ] || [ "$level" = "full-speed" ]; then
	class="full"
else
	class="manual"
fi

if [ "$speed" -lt 3000 ]; then
	speed_class="low"
elif [ "$speed" -lt 4500 ]; then
	speed_class="medium"
elif [ "$speed" -lt 5500 ]; then
	speed_class="high"
else
	speed_class="full"
fi

echo "{\"text\": \"$speed\", \"class\": \"$class $speed_class\", \"tooltip\": \"fan: $level\"}"
