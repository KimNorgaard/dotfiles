#!/bin/bash

if [ $BLOCK_BUTTON -eq 1 ]; then
  ~/bin/keymap.sh toggle
fi

LAYOUT=$(~/bin/keymap.sh get)

echo $LAYOUT
echo ${LAYOUT:0:1}
exit 0
