# MT Semantic Memory (MCP Server)

Este es el "Segundo Cerebro" del entorno Agentic DX. Es un servidor MCP (Model Context Protocol) escrito en Python que dota a la Inteligencia Artificial (Antigravity) de memoria vectorial a largo plazo utilizando **ChromaDB**.

## Componentes

1. **`server.py`**: El servidor MCP usando `FastMCP`. Expone dos herramientas (`store_memory` y `search_memory`) a la IA. Soporta modo local (SQLite) y modo remoto (HTTP).
2. **`indexer.py`**: Un script de ingesta automatizada que lee periódicamente la carpeta `~/cyber-brain` (Foam), calcula hashes de los archivos Markdown, y actualiza los embeddings en la base de datos si hay cambios. También soporta modo local/remoto.
3. **`backup.sh`**: Un script que comprime la carpeta `~/.gemini/memory_db` y la sube a Google Drive (macOS) o a una carpeta local (Linux). Opcionalmente hace push a un repositorio Git privado si `GIT_BACKUP_REPO` está definida.
4. **Archivos `.plist`**: Configuración de `launchd` de macOS para ejecutar la indexación y los backups en background.
5. **`systemd/mt-chroma.service`**: Daemon de Ubuntu para levantar el servidor HTTP de ChromaDB.

---

## Arquitectura

### Modo Local (por defecto / desarrollo)
Cada máquina tiene su propio ChromaDB en `~/.gemini/memory_db`. Sin configuración extra.

### Modo PRO — Single Source of Truth (Recomendado para múltiples máquinas)

```
┌──────────────┐     HTTP :8000    ┌────────────────────────┐
│   MacBook    │  ──────────────►  │   Ubuntu Server        │
│  (cliente)   │                   │   ChromaDB HTTP Server │
└──────────────┘                   └────────────────────────┘
```

Una única instancia de ChromaDB corre en el Ubuntu Server. Todas las máquinas clientes apuntan a ella via HTTP.

---

## Instalación y Arranque

Este proyecto usa `uv` como gestor de paquetes.

### 1. Inicializar el entorno
```bash
uv sync
```

### 2A. Configuración macOS (Modo Local)
Sin `.env`: usa ChromaDB local automáticamente.

Para los daemons de macOS:
```bash
cp com.lucha.mt.indexer.plist ~/Library/LaunchAgents/
cp com.lucha.mt.backup.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/com.lucha.mt.indexer.plist
launchctl load ~/Library/LaunchAgents/com.lucha.mt.backup.plist
```

### 2B. Configuración Ubuntu Server (Modo PRO — Servidor Central)

Levanta ChromaDB como daemon de systemd:
```bash
mkdir -p ~/.config/systemd/user
cp systemd/mt-chroma.service ~/.config/systemd/user/
cp systemd/mt-indexer.* ~/.config/systemd/user/
cp systemd/mt-backup.* ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable --now mt-chroma.service
systemctl --user enable --now mt-indexer.timer
systemctl --user enable --now mt-backup.timer
```

### 2C. Configuración macOS como Cliente Remoto (Modo PRO)

Crea un archivo `.env` en la raíz de `mt-mcp/`:
```env
# IP o hostname de tu Ubuntu Server
CHROMA_SERVER_HOST=192.168.1.X
CHROMA_SERVER_PORT=8000

# (Opcional) Repositorio Git privado para backup diario
GIT_BACKUP_REPO=git@github.com:TU_USUARIO/mt-memory-backups.git

# (Opcional) Override de la carpeta de backup local
# CLOUD_BACKUP_DIR=/tu/ruta/personalizada
```

> [!IMPORTANT]
> El archivo `.env` está en `.gitignore` para no exponer IPs ni URLs de repos privados. Configúralo manualmente en cada máquina.

### 3. Integración con Antigravity
El archivo `~/.gemini/config/mcp_config.json` es generado automáticamente por `agents/install.sh`. Solo asegúrate de correr `uv sync` antes de ejecutarlo.
