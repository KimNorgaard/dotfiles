#!/bin/sh

LAYOUT=$(setxkbmap -query | awk '/layout/{ print $2 }' | cut -d ',' -f 1)

case $1 in
  toggle)
    case $LAYOUT in
      us) setxkbmap -layout dk ;;
      *) setxkbmap -layout us -variant altgr-intl ;;
    esac
    # pkill -SIGRTMIN+12 i3blocks
    ;;
  get) echo $LAYOUT ;;
  notify) dunstify -i keyboard -t 2000 -r 4242 -u normal $LAYOUT
esac
