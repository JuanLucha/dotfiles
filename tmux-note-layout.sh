#! /bin/sh
# This is a default layout for note taking environment.

# The cool matrix effects are achieved using Cmatrix
# (https://github.com/abishekvashok/cmatrix)

# Execute this bash file in a tmux window

cd "$HOME/Desktop"

questsFile="Todo.md"

if [ ! -f $questsFile ]; then
  echo "# Quests" > $questsFile
fi

tmux rename-window quests
tmux move-window -t 9
tmux split-window -h -l 90%
tmux send-keys -t 0 "cmatrix -ba" "ENTER"
tmux split-window -h -l 20%
tmux send-keys -t 1 "vim $questsFile" "ENTER"
tmux send-keys -t 2 "cmatrix -baC cyan" "ENTER"

# Set default window
tmux select-pane -t 1


