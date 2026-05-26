#!/bin/bash
set -e

echo "🚀 Iniciando instalación de Ultimate AI Setup (Agentic DX)..."

GEMINI_CONFIG_DIR="$HOME/.gemini/config"
AGENTS_DIR="$HOME/.agents"
SETUP_DIR="$HOME/dotfiles/agents"
MCP_DIR="$HOME/dotfiles/mt-mcp"
OS=$(uname -s)

# 1. Asegurar que los directorios de configuración existen
mkdir -p "$GEMINI_CONFIG_DIR"
mkdir -p "$AGENTS_DIR/skills"

# 2. Instalar Universal Standards (System Prompt)
echo "🔗 Enlazando Universal Standards..."
ln -sf "$SETUP_DIR/system_prompt.md" "$GEMINI_CONFIG_DIR/system_prompt.md"

# 3. Instalar Skills creadas en este repo
echo "🔗 Enlazando Skills locales para Antigravity CLI..."
for skill_dir in "$SETUP_DIR/skills"/*; do
  if [ -d "$skill_dir" ]; then
    skill_name=$(basename "$skill_dir")
    echo "  -> Instalando skill: $skill_name"
    ln -sfn "$skill_dir" "$AGENTS_DIR/skills/$skill_name"
  fi
done

# 4. Generar mcp_config.json dinámico
echo "⚙️ Generando mcp_config.json con rutas absolutas locales..."
cat "$SETUP_DIR/mcp_config.template.json" | sed "s|\${HOME}|$HOME|g" > "$GEMINI_CONFIG_DIR/mcp_config.json"

# 5. Instalar automatizaciones de sistema (Indexador y Backup)
echo "🖥️ Detectando sistema operativo ($OS) para instalar demonios..."

if [ "$OS" = "Darwin" ]; then
    echo "🍎 Configurando launchd para macOS..."
    cp "$MCP_DIR"/com.lucha.mt.*.plist "$HOME/Library/LaunchAgents/"
    
    # Intentar descargar por si existían antes y cargar de nuevo
    launchctl unload "$HOME/Library/LaunchAgents/com.lucha.mt.indexer.plist" 2>/dev/null || true
    launchctl unload "$HOME/Library/LaunchAgents/com.lucha.mt.backup.plist" 2>/dev/null || true
    
    launchctl load "$HOME/Library/LaunchAgents/com.lucha.mt.indexer.plist"
    launchctl load "$HOME/Library/LaunchAgents/com.lucha.mt.backup.plist"
    echo "✅ Demonios launchd cargados."

elif [ "$OS" = "Linux" ]; then
    echo "🐧 Configurando systemd para Linux..."
    mkdir -p "$HOME/.config/systemd/user"
    cp "$MCP_DIR"/systemd/mt-indexer.* "$HOME/.config/systemd/user/"
    cp "$MCP_DIR"/systemd/mt-backup.* "$HOME/.config/systemd/user/"

    systemctl --user daemon-reload
    systemctl --user enable --now mt-indexer.timer
    systemctl --user enable --now mt-backup.timer
    echo "✅ Timers systemd habilitados."
else
    echo "⚠️ Sistema operativo no soportado para automatización automática. Inicia los scripts manualmente."
fi

echo "✅ Instalación completada con éxito."
