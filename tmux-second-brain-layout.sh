#! /bin/sh
# This is a default layout for second brain environment.

# The cool matrix effects are achieved using Cmatrix
# (https://github.com/abishekvashok/cmatrix)

# Execute this bash file in a tmux window

tmux rename-window "second-brain"
tmux move-window -t 9
tmux split-window -h -l 80%
tmux send-keys -t 0 "cmatrix -baC white u 10" "ENTER"
tmux split-window -h -l 20%
tmux send-keys -t 1 "vim index.md" "ENTER"
tmux send-keys -t 2 "cmatrix -baC cyan -u 10" "ENTER"

# Set default window
tmux select-pane -t 1


