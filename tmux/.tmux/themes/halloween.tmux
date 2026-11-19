# ==============================================================================
# Halloween tmux Theme
# Basado en el tema Halloween para VS Code (https://github.com/berensn/halloween)
# ==============================================================================

# Habilitar soporte TrueColor (24-bit)
set -g default-terminal "tmux-256color"
set -as terminal-overrides ",xterm*:Tc"

# --- Paleta de Colores ---
# bg_dark      = #151317  (Negro Noche Oscura)
# bg_status    = #1a181d  (Fondo Barra de Estado)
# bg_selection = #fb6e07  (Naranja Fuego / Selección)
# fg_main      = #c0bcba  (Gris Hueso Texto)
# fg_muted     = #7f848e  (Gris Lápida / Inactivo)
# orange       = #e6792a  (Naranja Calabaza)
# purple       = #bc59d9  (Púrpura Bruja)
# green        = #4bc02b  (Verde Slime)
# gold         = #e5c07b  (Dorado Cosecha)

# --- Barra de Estado General ---
set -g status "on"
set -g status-justify "left"
set -g status-style "bg=#1a181d,fg=#c0bcba"
set -g status-left-length "100"
set -g status-right-length "100"

# --- Bordes de Paneles (Panes) ---
set -g pane-border-style "fg=#383b3d"
set -g pane-active-border-style "fg=#e6792a"

# --- Mensajes y Modo Copia ---
set -g message-style "bg=#be5406,fg=#e4e4e4,bold"
set -g message-command-style "bg=#bc59d9,fg=#151317,bold"
set -g mode-style "bg=#fb6e07,fg=#151317,bold"

# --- Indicadores de Reloj y Paneles ---
set -g clock-mode-colour "#e6792a"
set -g display-panes-active-colour "#4bc02b"
set -g display-panes-colour "#bc59d9"

# --- Formato de la Barra de Estado ---

# Izquierda: Ventana activa con ícono Halloween
# Se muestra el índice de la ventana actual (no la sesión) para poder
# identificarla cuando la barra de estado queda recortada (ej. por SSH móvil).
set -g status-left "#[bg=#e6792a,fg=#151317,bold] 🎃 #{window_index} #[bg=#1a181d] "

# Derecha: Información del sistema (Fecha, Hora y Host)
set -g status-right "#[bg=#bc59d9,fg=#151317,bold] %Y-%m-%d #[bg=#e5c07b,fg=#151317,bold] %H:%M #[bg=#4bc02b,fg=#151317,bold] #h "

# --- Pestañas de Ventanas ---

# Ventana Inactiva
set -g window-status-format "#[fg=#7f848e,bg=#1a181d] #I:#W#F "

# Ventana Activa con Fantasma 👻 (Resaltada en Naranja Calabaza)
set -g window-status-current-format "#[fg=#151317,bg=#fb6e07,bold] 👻 #I:#W#F "

# Ventana con Actividad (Alertas/Alert)
set -g window-status-activity-style "fg=#4bc02b,bg=#1a181d,bold"
set -g window-status-bell-style "fg=#f48771,bg=#1a181d,bold"
