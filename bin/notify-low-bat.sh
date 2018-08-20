#!/bin/sh

su -c "/usr/bin/dunstify -i battery-caution -r 4243 -a power -u critical \"BATTERY LOW<br>$POWER_SUPPLY_CAPACITY%\"" kn
