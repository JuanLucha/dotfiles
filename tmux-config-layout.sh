#! /bin/sh
# This is a default layout for configuring dotfiles.

# The cool matrix effects are achieved using Cmatrix
# (https://github.com/abishekvashok/cmatrix)

# Execute this bash file in a tmux window

tmux rename-window config
tmux move-window -t 0
tmux split-window -h -l 90%
tmux send-keys -t 0 "cmatrix -bau 10" "ENTER"
tmux split-window -h -l 20%
tmux send-keys -t 1 "vim vimrc" "ENTER"

# Set default window
tmux select-pane -t 1


