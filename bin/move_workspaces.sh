#!/bin/sh

export DISPLAY=:0
export XAUTHORITY=/home/kn/.Xauthority

WS=${1:-eDP-1}
CURRENT_WS="$(i3-msg -t get_workspaces|jq -r '.[] | select(.focused==true).name')"

i3-msg "workspace 1; move workspace to $WS"
i3-msg "workspace 2; move workspace to $WS"
i3-msg "workspace 3; move workspace to $WS"
i3-msg "workspace 4; move workspace to $WS"
i3-msg "workspace 5; move workspace to $WS"

i3-msg "workspace $CURRENT_WS"
