#!/bin/bash

IFS=

SLEEP_STEP=30
SYNC_INTERVAL=300

while true; do
  ~/bin/syncmail.sh

  TIMELEFT=$SYNC_INTERVAL
  while [ $TIMELEFT -gt 0 ]; do
    echo -en "\r\033[K$TIMELEFT seconds until next sync."
    while read -t $SLEEP_STEP -s -n1 myin; do
      if [ "$myin" = "" ]; then
        echo
        echo "Enter pressed - checking mail."
        break 2
      fi
    done
    let TIMELEFT-=$SLEEP_STEP
  done
  echo -en "\r\033[K"
done
