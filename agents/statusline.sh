#!/bin/bash
input=$(cat)

# 1. Parse Left fields
cwd=$(echo "$input" | jq -r '.cwd // empty')
if [ -z "$cwd" ]; then
  cwd=$(echo "$input" | jq -r '.workspace // empty')
fi
if [ -z "$cwd" ]; then
  cwd=$(pwd)
fi

git_branch=""
if git -C "$cwd" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  git_branch=$(git -C "$cwd" branch --show-current 2>/dev/null)
fi

cwd_display="${cwd/#$HOME/\~}"

left_text=" 📁 $cwd_display"
if [ -n "$git_branch" ]; then
  left_text="$left_text ($git_branch)"
fi
left_text="$left_text "

# 2. Parse Right fields
model=$(echo "$input" | jq -r '.model | if type == "object" then .display_name else . end // empty')

# Remaining percentage for context window (formatted to 1 decimal place, e.g. 95.4%)
remaining_pct=$(echo "$input" | jq -r '.context_window | if .remaining_percentage != null then .remaining_percentage else (if .used_percentage != null then (100 - .used_percentage) else 100 end) end')
# Format to 1 decimal place if it has decimals
if [ -n "$remaining_pct" ]; then
  remaining_pct_formatted=$(printf "%.1f" "$remaining_pct" 2>/dev/null || echo "$remaining_pct")
fi

right_text=""
if [ -n "$remaining_pct_formatted" ]; then
  right_text=" ⚡ $remaining_pct_formatted%"
fi
if [ -n "$model" ]; then
  if [ -n "$right_text" ]; then
    right_text="$right_text |"
  fi
  right_text="$right_text 🤖 $model"
fi
right_text="$right_text "

# 3. Calculate alignment and padding
# Get terminal width
total_cols=$(echo "$input" | jq -r '.terminal_width // empty')
if [ -z "$total_cols" ] || [ "$total_cols" -eq 0 ]; then
  total_cols=$(tput cols 2>/dev/null || echo 80)
fi

# Subtract safety margin to prevent wrapping due to double-width emojis/characters
safety_margin=4
target_cols=$((total_cols - safety_margin))

# Get visible length of left and right sections
visible_len() {
    printf "%s" "$1" | sed 's/\x1b\[[0-9;]*m//g' | wc -m
}

left_len=$(visible_len "$left_text")
right_len=$(visible_len "$right_text")

# Calculate padding spaces
pad_len=$((target_cols - left_len - right_len))
if [ $pad_len -lt 1 ]; then
  pad_len=1
fi

# Generate padding spaces string
padding=$(printf '%*s' "$pad_len")

# Output the aligned status line
printf "%s%s%s" "$left_text" "$padding" "$right_text"
