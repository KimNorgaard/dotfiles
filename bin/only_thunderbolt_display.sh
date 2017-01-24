#!/bin/bash

xrandr --dpi 128 --output DP-2 --primary --output eDP-1 --off

pactl set-default-sink 1
