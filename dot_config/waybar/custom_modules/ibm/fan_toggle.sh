#!/bin/bash

current_level=$(awk '/^level:/{print $2}' /proc/acpi/ibm/fan)

if [ "$current_level" = "auto" ]; then
    pkexec ectool --interface=lpc fanduty 100
else
    pkexec ectool --interface=lpc autofanctrl
fi
