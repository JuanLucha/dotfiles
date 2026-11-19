# ==============================================================================
# Cyberpunk 80s tmux Theme
# Recuperado del tema original en tmux.conf (commit 96128e4)
# ==============================================================================

set -g status-style bg="#0d0221",fg="#00ffff"
set -g window-status-style bg="#0d0221",fg="#8a2be2"
set -g window-status-current-style bg="#0d0221",fg="#ff007f",bold
set -g window-status-format "#I:#W#{?window_zoomed_flag, #[fg=yellow]Z#[default],}"
set -g window-status-separator " #[fg=#5cc5ff]⚡#[default] "
set -g pane-border-style fg="#261447"
set -g pane-active-border-style fg="#ff007f"
set -g message-style bg="#00ffff",fg="#0d0221",bold
set -g mode-style bg="#ff007f",fg="#0d0221",bold

# --- Iconos (mismo espíritu que el tema Halloween) ---

# Izquierda: badge neón con el índice de ventana (como el 🎃 de Halloween)
set -g status-left "#[bg=#ff007f,fg=#0d0221,bold] 🌃 #{window_index} #[bg=#0d0221,fg=#00ffff] "

# Ventana activa:👾 resaltada en rosaláser (como el 👻 de Halloween)
set -g window-status-current-format "#[fg=#0d0221,bg=#ff007f,bold] 👾 #I:#W#F "

# Derecha: Pomodoro + fecha, hora y host con iconos.
# El comando del plugin se conserva para no perder el Pomodoro al cambiar de tema.
set -g status-right "#(~/.tmux/plugins/tmux-pomodoro-plus/scripts/pomodoro.sh)#[bg=#8a2be2,fg=#0d0221,bold] 📅 %Y-%m-%d #[bg=#00ffff,fg=#0d0221,bold] 🕐 %H:%M #[bg=#ff007f,fg=#0d0221,bold] 🌐 #h #[bg=#0d0221] "
set -g status-left-length "100"
set -g status-right-length "100"
