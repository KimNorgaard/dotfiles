#!/bin/bash

SLEEP_STEP=10
SYNC_INTERVAL=300

while true; do
  ~/bin/syncmail.sh

  TIMELEFT=$SYNC_INTERVAL
  while [ $TIMELEFT -gt 0 ]; do
    echo -en "\r\033[K$TIMELEFT seconds until next sync."
    sleep $SLEEP_STEP
    let TIMELEFT-=$SLEEP_STEP
  done
  echo -en "\r\033[K"
done
