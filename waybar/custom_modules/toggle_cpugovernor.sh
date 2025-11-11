#!/bin/bash

current=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)

if [ "$current" = "powersave" ]; then
	new="performance"
else
	new="powersave"
fi

pkexec sh -c "for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do echo '$new' > \"\$cpu\"; done"
pkill -RTMIN+2 waybar
