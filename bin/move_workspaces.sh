#!/bin/sh

export DISPLAY=:0
export XAUTHORITY=/home/kn/.Xauthority

#CURRENT_WS="$(i3-msg -t get_workspaces|jq -r '.[] | select(.focused==true).name')"

i3-msg "workspace 1:web; move workspace to output primary"
i3-msg "workspace 2:mail; move workspace to output primary"
i3-msg "workspace 3:term; move workspace to output primary"
i3-msg "workspace 4:chat; move workspace to output primary"
i3-msg "workspace 5; move workspace to output primary"
