#!/bin/bash

cd /etc/netctl

SELECTED="$(sudo ls -p | grep -v / | fzf --preview="netctl status {}")"

STATUS=$(sudo netctl is-active "$SELECTED")

if [ $STATUS = "active" ]; then
  echo "$SELECTED is alrady active"
else
  echo "Switching to $SELECTED"
  sudo netctl switch-to "$SELECTED"
fi
