#!/bin/sh

LAYOUT=$(setxkbmap -query | awk '/layout/{ print $2 }' | cut -d ',' -f 1)

case $1 in
  toggle)
    case $LAYOUT in
      us) setxkbmap -layout dk ;;
      *) setxkbmap -layout us ;;
    esac
    pkill -SIGRTMIN+12 i3blocks
    ;;
  get) echo $LAYOUT ;;
esac
