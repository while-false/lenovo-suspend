#!/usr/bin/bash

BATTERY_PATH="$(find /sys/devices/ | grep 'BAT0$')"
CRITICAL_LEVEL=20
CRITICAL_ACTION="systemctl suspend"

[ ! -d "${BATTERY_PATH}" ] &&
    echo "Could not find battery." &&
    exit -1 

while true; do
    [[ $(cat "${BATTERY_PATH}/capacity") -lt ${CRITICAL_LEVEL} ]] && 
        echo "Battery below critical." &&
        ${CRITICAL_ACTION} &&
        exit

    sleep 5
done

