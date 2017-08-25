#!/bin/sh
bl_dev=/sys/class/backlight/intel_backlight
step=200

case $1 in
  -) echo $(($(< $bl_dev/brightness) - $step)) > $bl_dev/brightness;;
  +) echo $(($(< $bl_dev/brightness) + $step)) > $bl_dev/brightness;;
esac
