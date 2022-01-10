#! /bin/bash
# This is a default layout for solo rpg sessions

# Execute this bash file in a tmux window

tmux rename-window dev
tmux split-window -h -l 90%
# tmux split-window -h -l 20%
# tmux split-window -v
# tmux split-window -v -l 20%
# tmux send-keys -t 1 "vim" "ENTER"
# tmux send-keys -t 4 "cmatrix -baC magenta" "ENTER"

# # Set default window
tmux select-pane -t 1

