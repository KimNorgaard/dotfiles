#!/bin/sh

DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
su -p -c "/usr/bin/dunstify -i battery-caution -r 4243 -a power -u critical \"BATTERY LOW<br>$POWER_SUPPLY_CAPACITY%\"" kn
