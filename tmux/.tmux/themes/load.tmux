# ==============================================================================
# Theme loader
# Resets every theme-owned option before sourcing the selected theme, so
# switching themes never leaves leftovers from the previous one.
# The active theme is stored in the global @theme option.
# ==============================================================================

set -g status on
set -gu status-justify
set -gu status-left
set -gu status-left-length
# The pomodoro plugin only interpolates its #{pomodoro_status} placeholder when
# the config is sourced, so use its shell command directly to survive cycling.
set -g status-right "#(~/.tmux/plugins/tmux-pomodoro-plus/scripts/pomodoro.sh)"
set -gu status-right-length
set -gu status-style
set -gu window-status-style
set -gu window-status-current-style
set -gu window-status-format
set -gu window-status-current-format
set -gu window-status-separator
set -gu window-status-activity-style
set -gu window-status-bell-style
set -gu pane-border-style
set -gu pane-active-border-style
set -gu message-style
set -gu message-command-style
set -gu mode-style
set -gu clock-mode-colour
set -gu display-panes-active-colour
set -gu display-panes-colour

if-shell -F '#{==:#{@theme},halloween}' \
  'source-file ~/.tmux/themes/halloween.tmux' \
  'source-file ~/.tmux/themes/cyberpunk.tmux'
