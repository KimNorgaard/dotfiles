#!/bin/bash

BR_DEV=/sys/class/backlight/intel_backlight
BR_MAX=$(cat $BR_DEV/max_brightness)

case "$1" in
	ac)
		BR_NEW=$BR_MAX
		;;
	bat)
		BR_NEW=$(($BR_MAX / 2))
		;;
	*)
		echo "use $0 [ac|bat]"
		exit
		;;
esac

echo $BR_NEW > $BR_DEV/brightness
