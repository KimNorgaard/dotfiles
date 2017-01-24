#!/bin/bash
export DISPLAY=:0.0
BATPATH=/sys/class/power_supply/BAT0
BAT_FULL=$BATPATH/charge_full
BAT_NOW=$BATPATH/charge_now
BAT_STATUS=$BATPATH/status
bf=$(cat $BAT_FULL)
bn=$(cat $BAT_NOW)
bs=$(cat $BAT_STATUS)
echo $(( 100 * $bn / $bf ))
echo $bs
if [ $(( 100 * $bn / $bf )) -lt 15 ] && [ "$bs" == 'Discharging' ]
then
    /usr/bin/notify-send -i /usr/share/icons/Adwaita/256x256/status/battery-low.png "LOW BATTERY! PLUG IN LAPTOP!"
fi

if [ $(( 100 * $bn / $bf )) -lt 10 ] && [ $bs = 'Discharging' ]
then
    /usr/bin/paplay /usr/share/sounds/purple/alert.wav
fi

#if [ $(( 100 * $bn / $bf )) -lt 5 ] && [ $bs = 'Discharging' ]
#then
#    systemctl poweroff
#fi
