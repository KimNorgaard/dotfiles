#!/bin/sh

DPMS_STATE=$(xset q | grep "DPMS is" | awk '{print $3}')

if [ $DPMS_STATE = "Disabled" ]; then
  notify-send -t 5 -a DPMS "Turning on DPMS"
  xset s on +dpms
else
  notify-send -t 5 -a DPMS "Turning off DPMS"
  xset s off -dpms
fi
