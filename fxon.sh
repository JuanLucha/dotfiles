#! /bin/sh
# Script to enable cmatrix effects on dev screen

# The cool matrix effects are achieved using Cmatrix
# (https://github.com/abishekvashok/cmatrix)

# Execute this bash file in a tmux window with the tmux-dev-layout.sh executed

tmux send-keys -t 0 "cmatrix -ba" "ENTER"
tmux send-keys -t 4 "cmatrix -baC cyan" "ENTER"

