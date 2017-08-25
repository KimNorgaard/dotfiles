#!/bin/bash

#sleep 5
#set -e

activeMonitors=$(xrandr --listactivemonitors)

monitorCount=$(echo "$activeMonitors" | grep "Monitors:" | awk '{print $2}')
laptopMonitor=$(echo "$activeMonitors" | grep "0:" |awk '{print $4}')
secondMonitor=$(echo "$activeMonitors" | grep "1:" |awk '{print $4}')

export DISPLAY=:0
export XAUTHORITY=/home/kn/.Xauthority

if [ $monitorCount -eq 1 ]; then
  xrandr --auto --output $laptopMonitor --primary
  /home/kn/bin/move_workspaces.sh $laptopMonitor
fi


if [ $monitorCount -eq 2 ]; then
  xrandr --output $secondMonitor --left-of $laptopMonitor --auto --primary
  /home/kn/bin/move_workspaces.sh $secondMonitor
fi

xmodmap ~/.Xmodmap
xset r rate 250 25

/home/kn/bin/set_background.sh
