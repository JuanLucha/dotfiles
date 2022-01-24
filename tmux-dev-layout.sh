#! /bin/bash
# This is a default layout for development environment.

# The cool matrix effects are achieved using Cmatrix
# (https://github.com/abishekvashok/cmatrix)

# Execute this bash file in a tmux window

tmux split-window -h -l 85%
tmux split-window -h -l 20%
tmux send-keys -t 1 "vim" "ENTER"

# # Set default window
tmux select-pane -t 1

