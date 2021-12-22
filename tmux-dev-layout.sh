#! /bin/bash
# This is a default layout for development environment.
# The cool matrix effects are achieved using Cmatrix
# (https://github.com/abishekvashok/cmatrix)

SESSION=development

tmux -2 new-session -d -s $SESSION -x $(tput cols) -y $(tput lines)

tmux new-window -t $SESSION
tmux split-window -h -l 90%
tmux send-keys -t 0 "cmatrix -ba" "ENTER"
tmux split-window -h -l 20%
tmux split-window -v
tmux split-window -v -l 20%
tmux send-keys -t 1 "vim" "ENTER"
tmux send-keys -t 4 "cmatrix -baC magenta" "ENTER"

# Set default window
tmux select-window -t $SESSION:1
tmux select-pane -t 2

# Attach to session
tmux -2 attach-session -t $SESSION
