#!/bin/bash

current_level=$(awk '/^level:/{print $2}' /proc/acpi/ibm/fan)

if [ "$current_level" = "auto" ]; then
	echo "level full-speed" | pkexec tee /proc/acpi/ibm/fan >/dev/null
else
	echo "level auto" | pkexec tee /proc/acpi/ibm/fan >/dev/null
fi
