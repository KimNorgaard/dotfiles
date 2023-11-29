#!/bin/sh

tmux ls -F '#{session_name} #{session_attached}' -f '#{==:#{session_name},work}' | grep -q work && exit

tmux new -s work -d
tmux set-option -t work base-index 0
# tmux rename-window -t work mutt
# tmux move-window -s work:1 -t work:0
# tmux send-keys -t work 'mutt' C-m
tmux rename-window -t work vim
tmux move-window -s work:1 -t work:0
tmux send-keys -t work 'vim' C-m
tmux new-window -t work
tmux new-window -t work
tmux select-window -t work:1
tmux attach -t work
