#!/bin/sh
last_file=$(ls -art ${HOME}/*_scrot.png|tail -1)
xclip -selection clipboard -target image/png "$last_file"
