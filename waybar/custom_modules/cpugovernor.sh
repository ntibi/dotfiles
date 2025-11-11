#!/bin/bash

governor=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)

declare -A governor_map=(
	["powersave"]="save"
	["performance"]="perf"
	["schedutil"]="sched"
	["ondemand"]="ondemand"
	["conservative"]="cons"
	["userspace"]="user"
)

mapped=${governor_map[$governor]:-$governor}

echo "{\"text\": \"$mapped\", \"class\": \"$mapped\", \"tooltip\": \"$governor\"}"
