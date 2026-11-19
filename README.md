# ultimate-ai-setup (Dotfiles)

Repositorio centralizado de configuración de desarrollo y automatización de Inteligencia Artificial (Agentic DX), compatible de forma nativa con **macOS** y **Ubuntu Server**.

## Estructura del Repositorio

- **`agents/`**: Configuración global de agentes de IA (Antigravity y `agy` CLI).
  - `system_prompt.md`: Directivas base (MariTere, Caveman mode, TDD, memoria semántica).
  - `AGENTS.md`: Reglas globales del harness (identidad, uso de `code-now`, prioridad de modelos).
  - `agents/`: Subagentes del patrón Leader/Worker/Reviewer (`coder.md`, `reviewer.md`).
  - `skills/`: Habilidades inyectables que los agentes pueden invocar (`code-now`).
- **`mt-mcp/`**: Servidor de Memoria Semántica Avanzada (Model Context Protocol).
  - `server.py`: Servidor basado en ChromaDB.
  - `indexer.py`: Script de ingesta periódica para notas Foam (`cyber-brain`).
  - `backup.sh`: Compresión y rotación (7 días) de la base de datos de memoria.
  - `systemd/` y `*.plist`: Orquestadores de demonios para Linux y macOS.
- **Clásicos (`nvim/`, `vim/`, `tmux/`, `zshrc`)**: Configuración base de terminal y edición.

---

## Quickstart: Instalación en 3 Pasos

Sigue este orden exacto para evitar dependencias rotas (especialmente el entorno de Python antes del enlace de MCP).

### Paso 1: Requisitos Previos
Asegúrate de tener `uv` instalado para gestionar el entorno de Python:
```bash
# macOS / Linux
curl -LsSf https://astral.sh/uv/install.sh | sh
```

### Paso 2: Inicializar la Memoria Semántica (MT MCP)
Crea el entorno virtual y descarga las dependencias del servidor MCP:
```bash
cd mt-mcp
uv sync
cd ..
```
*Esto creará la carpeta `.venv` requerida por el cargador de MCP.*

### Paso 3: Enlazar la Configuración y los Demonios
Crea los enlaces simbólicos a mano (o con `stow`) y levanta los daemons del sistema:
```bash
ln -sf "$PWD/agents/system_prompt.md" ~/.gemini/config/system_prompt.md
ln -sf "$PWD/agents/statusline.sh" ~/.gemini/antigravity-cli/statusline.sh
```
Para las skills, enlaza cada carpeta de `agents/skills/` en los directorios que
lea tu cliente (`~/.agents/skills`, `~/.claude/skills`, `~/.gemini/skills`,
`~/.config/opencode/skills`).

Los demonios de memoria se instalan desde `mt-mcp/` (`*.plist` con `launchctl` en
macOS, `systemd/` con `systemctl --user` en Linux).

---

## Arquitectura de Memoria Semántica

### Modo Local (por defecto)
Sin configuración extra. Cada máquina tiene su propio ChromaDB local en `~/.gemini/memory_db`.

### Modo PRO — Memoria Compartida entre Máquinas
Si tienes varias máquinas (ej. Mac + Ubuntu Server), puedes centralizar la memoria vectorial en el servidor Ubuntu. Todas las máquinas leerán y escribirán en la misma base de datos.

Ver instrucciones detalladas en [`mt-mcp/README.md`](mt-mcp/README.md).



---

## Configuración Opcional

### Personalizar Backups de Memoria
Por defecto:
- **macOS** intenta guardar los backups comprimidos en tu Google Drive montado localmente: `~/Google Drive/Mi unidad/Backups/MT`.
- **Linux/Ubuntu** los guarda localmente en `~/backups/mt_memory_backups`.

Para forzar una ruta específica (ej. otra carpeta en la nube o disco externo), crea un archivo `.env` en la raíz de `mt-mcp/`:
```env
CLOUD_BACKUP_DIR="/tu/ruta/personalizada"
```
El script de backup detectará automáticamente este archivo al ejecutarse por cron/timer.
