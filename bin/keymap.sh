#!/bin/sh

LAYOUT=$(setxkbmap -query | awk '/layout/{ print $2 }' | cut -d ',' -f 1)

NOTIFY_CMD="dunstify -i keyboard -t 2000 -r 4242 -u normal"

case $1 in
  toggle)
    case $LAYOUT in
      us) LAYOUT="dk"; setxkbmap -layout $LAYOUT ;;
      *) LAYOUT="us"; setxkbmap -layout $LAYOUT -variant altgr-intl ;;
    esac
    if [ "$2" = "notify" ]; then
      $NOTIFY_CMD $LAYOUT
    fi
    # pkill -SIGRTMIN+12 i3blocks
    ;;
  get) echo $LAYOUT ;;
  notify) $NOTIFY_CMD $LAYOUT;;
esac
