#! /bin/bash
# This is a default layout for development environment.

# The cool matrix effects are achieved using Cmatrix
# (https://github.com/abishekvashok/cmatrix)

# Execute this bash file in a tmux window

tmux rename-window dev
tmux split-window -h -l 90%
tmux send-keys -t 0 "cmatrix -bau 10" "ENTER"
tmux split-window -h -l 20%
tmux split-window -v
tmux split-window -v -l 20%
tmux send-keys -t 1 "vim" "ENTER"
tmux send-keys -t 4 "cmatrix -baC magenta -u 10" "ENTER"

# # Set default window
tmux select-pane -t 1

