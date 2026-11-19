# Agentic DX (Global AI Setup)

Configuración global de agentes de IA (Antigravity/agy, Claude Code, OpenCode).
Esta carpeta es la fuente de verdad: los clientes la consumen mediante enlaces
simbólicos, no copias.

## Estructura

- `AGENTS.md`: Reglas globales del harness (idioma, identidad, uso obligatorio de
  `code-now`, prioridad de modelos por rol).
- `agents/`: Definiciones de subagentes del patrón Leader/Worker/Reviewer.
  - `coder.md`: Worker (Flash). Ejecuta un micro-plan y valida con build/lint/tests.
  - `reviewer.md`: Reviewer (Pro). Devuelve un veredicto estructurado 0/1.
- `skills/`: Habilidades inyectables que los agentes pueden invocar.
  - `code-now`: Bucle de programación Leader/Worker/Reviewer con válvula de seguridad.
- `system_prompt.md`: Universal Standards (personalidad MT, comunicación concisa,
  TDD, directiva de memoria semántica).
- `statusline.sh`: Línea de estado personalizada para el CLI de Antigravity (`agy`):
  workspace, rama Git, modelo activo y uso de contexto.

## Comandos de OpenCode

Los slash commands **no viven en este repositorio**: están en
`~/.config/opencode/commands/`. Los comandos no son invocables por un modelo,
por eso todo lo que un agente debe poder ejecutar por su cuenta vive en
`skills/`.

## Memoria Semántica (MT MCP)

Este entorno depende de un MCP Server independiente que dota al agente de memoria
a largo plazo conectada a una base de datos vectorial local (ChromaDB) y a un
sistema de notas Foam (`cyber-brain`).

El código de ese servidor **NO** vive aquí (para no contaminar la configuración
con entornos de Python). Vive en `../mt-mcp/`.

## Enlazado

Los enlaces simbólicos hacia `~/.gemini/`, `~/.agents/`, `~/.claude/` y
`~/.config/opencode/` se crean a mano (o con una herramienta tipo `stow`).
Los ya existentes apuntan a esta carpeta y siguen siendo válidos.

### Configuración del Statusline en el CLI (`agy`)

Para que el CLI use `statusline.sh`, añade esta sección a
`~/.gemini/antigravity-cli/settings.json`:

```json
{
  "statusLine": {
    "type": "command",
    "command": "~/.gemini/antigravity-cli/statusline.sh",
    "enabled": true
  }
}
```
