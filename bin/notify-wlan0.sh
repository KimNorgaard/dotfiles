#!/bin/bash

if [ "$1" = "up" ]; then
  myssid=$(iwgetid -r)
  quality=$(awk '/ *wlan0/{gsub("[.]","",$3); print $3}' /proc/net/wireless)
  ip=$(ip addr show wlan0 | awk 'match($0, /inet6? ([^\/]+)/, ip) {print ip[1]}')
  notify-send -i nm-device-wireless -t 5000 -u normal "wlan0 up<br>$myssid<br>$quality%<br>$ip" &
else
  notify-send -i nm-device-wireless -t 5000 -u critical "wlan0 down" &
  sleep 5
fi
