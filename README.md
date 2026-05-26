# ultimate-ai-setup (Dotfiles)

Repositorio centralizado de configuración de desarrollo y automatización de Inteligencia Artificial (Agentic DX), compatible de forma nativa con **macOS** y **Ubuntu Server**.

## Estructura del Repositorio

- **`agents/`**: Configuración global de agentes de IA (Antigravity y `agy` CLI).
  - `system_prompt.md`: Directivas base (MariTere, Caveman mode, TDD, memoria semántica).
  - `skills/`: Habilidades inyectables para automatizar tareas (ej. `init-project` en Markdown puro).
  - `install.sh`: Script maestro de instalación y enlace de demonios.
- **`mt-mcp/`**: Servidor de Memoria Semántica Avanzada (Model Context Protocol).
  - `server.py`: Servidor basado en ChromaDB.
  - `indexer.py`: Script de ingesta periódica para notas Foam (`cyber-brain`).
  - `backup.sh`: Compresión y rotación (7 días) de la base de datos de memoria.
  - `systemd/` y `*.plist`: Orquestadores de demonios para Linux y macOS.
- **Clásicos (`nvim/`, `tmux.conf`, `zshrc`, `vimrc`)**: Configuración base de terminal y edición.

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

### Paso 3: Ejecutar el Instalador Maestro
Enlaza el system prompt, registra el servidor MCP, instala las skills y levanta los daemons del sistema (LaunchAgents en macOS o systemctl en Linux):
```bash
cd agents
chmod +x install.sh
./install.sh
```

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
