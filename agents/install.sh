#!/bin/bash
set -e

echo "🚀 Iniciando instalación de Ultimate AI Setup (Agentic DX)..."

GEMINI_CONFIG_DIR="$HOME/.gemini/config"
SETUP_DIR="$HOME/dotfiles/agents"

# 1. Asegurar que el directorio de configuración global existe
mkdir -p "$GEMINI_CONFIG_DIR/skills"

# 2. Instalar Universal Standards (System Prompt)
# Si Antigravity lee plugins o skills generales, podemos inyectar esto como un .md base.
# Lo copiamos/symlinkeamos a una ubicación donde Antigravity pueda cargarlo.
# Nota: La implementación exacta de "system prompt global" depende del loader de Antigravity.
# Por ahora lo metemos en config/.
echo "🔗 Enlazando Universal Standards..."
ln -sf "$SETUP_DIR/system_prompt.md" "$GEMINI_CONFIG_DIR/system_prompt.md"

# 3. Instalar Skills creadas en este repo
echo "🔗 Enlazando Skills locales..."
for skill_dir in "$SETUP_DIR/skills"/*; do
  if [ -d "$skill_dir" ]; then
    skill_name=$(basename "$skill_dir")
    echo "  -> Instalando skill: $skill_name"
    ln -sfn "$skill_dir" "$GEMINI_CONFIG_DIR/skills/$skill_name"
  fi
done

echo "✅ Fase 1 completada. Universal Standards y Skills base enlazadas a $GEMINI_CONFIG_DIR"
