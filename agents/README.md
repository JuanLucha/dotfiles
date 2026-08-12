# Agentic DX (Global AI Setup)

Esta carpeta contiene la configuración global y las skills base para el entorno de desarrollo asistido por Inteligencia Artificial (Antigravity/Gemini). 

Toda la configuración aquí presente se sincroniza globalmente mediante un script de instalación.

## Estructura

- `system_prompt.md`: Define los **Universal Standards**. Aquí se instruye a la IA sobre su personalidad (MT / MariTere), la preferencia por comunicación concisa (Caveman Mode), metodologías (TDD) y su directiva de Memoria Semántica Autónoma.
- `skills/`: Contiene habilidades inyectables.
  - `init-project`: Genera una plantilla de `CONTEXT.md` en nuevos repositorios para aislar las reglas locales del proyecto de las reglas globales.
- `statusline.sh`: Script de bash para renderizar una línea de estado personalizada en la barra inferior del CLI de Antigravity (`agy`), alineando información dinámica como el workspace, la rama Git, el modelo activo y el uso de contexto.
- `install.sh`: Script que crea enlaces simbólicos (symlinks) de todos estos archivos hacia sus respectivas rutas en `~/.gemini/` y `~/.agents/`, haciendo que este repositorio sea la fuente de verdad.

## Memoria Semántica (MT MCP)

Este entorno depende de un **MCP Server** independiente que dota al agente de memoria a largo plazo conectada a una base de datos vectorial local (ChromaDB) y a un sistema de notas Foam (`cyber-brain`).

El código de ese servidor **NO** vive aquí (para no contaminar la configuración con entornos de Python). Vive en `../mt-mcp/`.

## Instalación

Para sincronizar esta configuración con tu cliente de IA:

```bash
chmod +x install.sh
./install.sh
```

### Configuración del Statusline en el CLI (`agy`)
El script de instalación enlazará `statusline.sh` a `~/.gemini/antigravity-cli/statusline.sh`. Para que el CLI lo utilice, debes asegurarte de tener la siguiente sección en tu archivo `~/.gemini/antigravity-cli/settings.json`:

```json
{
  "statusLine": {
    "type": "command",
    "command": "/home/lucha/.gemini/antigravity-cli/statusline.sh",
    "enabled": true
  }
}
```

