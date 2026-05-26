# MT Semantic Memory (MCP Server)

Este es el "Segundo Cerebro" del entorno Agentic DX. Es un servidor MCP (Model Context Protocol) escrito en Python que dota a la Inteligencia Artificial (Antigravity) de memoria vectorial a largo plazo utilizando **ChromaDB**.

## Componentes

1. **`server.py`**: El servidor MCP usando `FastMCP`. Expone dos herramientas (`store_memory` y `search_memory`) a la IA. La IA puede usar estas herramientas de forma autónoma gracias a las directivas en su `system_prompt.md` global.
2. **`indexer.py`**: Un script de ingesta automatizada que lee periódicamente la carpeta `/Users/lucha/cyber-brain` (Foam), calcula hashes de los archivos Markdown, y actualiza los embeddings en la base de datos si hay cambios.
3. **`backup.sh`**: Un script que comprime la carpeta `~/.gemini/memory_db` (donde ChromaDB persiste sus datos localmente) y la sube a Google Drive, manteniendo solo los backups de los últimos 7 días.
4. **Archivos `.plist`**: Configuración de `launchd` de macOS para ejecutar la indexación y los backups en background de forma desatendida.

## Instalación y Arranque

Este proyecto usa `uv` como gestor de paquetes y entornos virtuales.

### 1. Inicializar el entorno
Si acabas de clonar el repositorio:
```bash
uv sync
```

### 2. Configurar la automatización (Daemons de macOS)
Para que el cerebro se mantenga actualizado leyendo el `cyber-brain` automáticamente cada hora, y se haga el backup cada noche:

```bash
# Copiar las definiciones de launchd al sistema
cp com.lucha.mt.indexer.plist ~/Library/LaunchAgents/
cp com.lucha.mt.backup.plist ~/Library/LaunchAgents/

# Cargar los demonios
launchctl load ~/Library/LaunchAgents/com.lucha.mt.indexer.plist
launchctl load ~/Library/LaunchAgents/com.lucha.mt.backup.plist
```

### 3. Integración con Antigravity
Asegúrate de que en el archivo `~/.gemini/config/mcp_config.json` de tu cliente exista una entrada llamada `mt_memory` que apunte al comando `python` de este entorno virtual (`.venv/bin/python`) y al archivo `server.py`.
