#!/bin/sh
clipster -o -n10 -0 | rofi -dmenu -i -sep '\x00' -eh 3 -p paste | sed -ze 's/\n$//' | clipster
