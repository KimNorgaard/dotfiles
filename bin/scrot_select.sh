#!/bin/sh
# Because, when running via hotkey from a WM it needs a delay, and dwm doesn't
# support running chained commands.
sleep 0.4 && scrot -s
