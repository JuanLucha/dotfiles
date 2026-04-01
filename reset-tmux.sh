#! /bin/bash
# This is a default layout for development environment.

### Cleans session

# Check if we are inside a tmux session
if [ -n "$TMUX" ]; then
  # Get the current session ID
  current_session=$(tmux display-message -p '#{session_id}')

  # Kill the current session
  tmux kill-session -t "$current_session"

  echo "Current tmux session has been killed."
fi

# Create a new tmux session in detached mode
tmux new-session -d

current_session=$(tmux display-message -p '#{session_id}')


### Creates the setup window

setup_base_folder='dotfiles'

setup_paths=(
  "nvim/init.lua"
  "zshrc"
  "tmux.conf"
  "reset-tmux.sh"
)

# Set the window name
tmux rename-window "setup"

# Split the window into 4 equal panes
tmux setw remain-on-exit on

tmux splitw -h
tmux splitw -v
tmux selectp -t 0
tmux splitw -v

# Open each file in the corresponding pane
for i in {0..3}; do
    tmux selectp -t $i
    tmux send-keys "cd ${setup_base_folder} && vim ${setup_paths[$i]}" Enter
done

# Leave open host file
tmux splitw -v
tmux send-keys "sudo nvim /etc/hosts" Enter

# Select the first pane
tmux selectp -t 0

# Set remain-on-exit back to off
tmux setw remain-on-exit off



### Creates session with all the windows

# Array of window names
window_names=(
  "code"
  "cobra-ssg"
  "listag-frontend-angular"
  "listag-backend"
  "johnfightgaming"
  "After Xmas"
)

# Array of paths
paths=(
  "~/code"
  "~/code/cobra-ssg"
  "~/code/listag-frontend-angular"
  "~/code/listag-backend"
  "~/code/johnfightgaming"
  "~/code/after-xmas"
)

# Loop through the window names
for i in "${!window_names[@]}"; do
  tmux new-window

  # Set the window name
  tmux rename-window "${window_names[$i]}"

  # Split the window into 4 panes
  tmux split-window -h
  tmux select-pane -t 0
  tmux split-window -v
  tmux split-window -v

  # The right panel wider, for coding, for example
  tmux resize-pane -t 3 -x 200

  # Navigate to the specific folder in all four panes (pane 0, 1, 2, 3)
  for j in {0..3}; do
    tmux send-keys -t "${window_names[$i]}.${j}" "cd ${paths[$i]}" Enter
  done
done

# Select the first window
tmux select-window -t "${current_session_id}:0"

# Attach to the session
tmux attach-session -t "${current_session_id}"

