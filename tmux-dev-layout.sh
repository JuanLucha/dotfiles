#! /bin/bash
SESSION=development

tmux -2 new-session -d -s $SESSION -x $(tput cols) -y $(tput lines)

tmux new-window -t $SESSION
tmux split-window -h -l 20%
tmux split-window -v
tmux send-keys -t 0 "vim" "ENTER"

# Set default window
tmux select-window -t $SESSION:1
tmux select-pane -t 0

# Attach to session
tmux -2 attach-session -t $SESSION
