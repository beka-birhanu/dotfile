#!/bin/bash

BATTINFO=$(acpi -b)

if [[ $(echo "$BATTINFO" | grep Discharging) && $(echo "$BATTINFO" | cut -f 4 -d " " | cut -f 1 -d "," | cut -f 1 -d "%") -lt 15 ]]; then
    DISPLAY=:0.0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send "Low Battery" "$BATTINFO"
fi
