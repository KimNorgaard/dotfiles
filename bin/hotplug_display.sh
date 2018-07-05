#!/bin/bash

export DISPLAY=:0
export XAUTHORITY=/home/kn/.Xauthority

LAPTOP_MONITOR=$(xrandr --listactivemonitors | grep -i eDP | awk '{print $4}')

xrandr --output $LAPTOP_MONITOR --auto --primary
PRIMARY_MONITOR=$LAPTOP_MONITOR

for MONITOR in $(xrandr -q | grep "disconnected" | grep -iv eDP | awk '{print $1}'); do
  xrandr --output $MONITOR --off
done

for MONITOR in $(xrandr -q | grep "\bconnected" | grep -iv eDP | awk '{print $1}'); do
  echo Found $MONITOR
  xrandr --output $MONITOR --auto --primary --right-of $LAPTOP_MONITOR
  PRIMARY_MONITOR=$MONITOR
done

echo Primary monitor is $PRIMARY_MONITOR

/home/kn/bin/move_workspaces.sh $PRIMARY_MONITOR

xmodmap ~/.Xmodmap
xset r rate 350 40

/home/kn/bin/set_background.sh
