#!/bin/bash
set -e

# Configuración
MEMORY_DIR="$HOME/.gemini/memory_db"

# Cargar variables de entorno si existen
if [ -f "$HOME/dotfiles/mt-mcp/.env" ]; then
    source "$HOME/dotfiles/mt-mcp/.env"
fi

DATE=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILENAME="mt_memory_${DATE}.tar.gz"
TEMP_BACKUP_PATH="/tmp/${BACKUP_FILENAME}"

echo "📦 Iniciando backup de la memoria semántica (ChromaDB)..."

if [ ! -d "$MEMORY_DIR" ]; then
    echo "⚠️  No se encontró la base de datos en $MEMORY_DIR. Abortando backup."
    exit 0
fi

# Comprimir la carpeta de memoria
echo "🗜️  Comprimiendo base de datos..."
tar -czf "$TEMP_BACKUP_PATH" -C "$(dirname "$MEMORY_DIR")" "$(basename "$MEMORY_DIR")"

# -----------------------------------------------------------------------
# Bloque 1: Backup a Google Drive / carpeta local
# -----------------------------------------------------------------------
# Asignar directorio de backup por defecto según OS si no está definido en .env
if [ -z "$CLOUD_BACKUP_DIR" ]; then
    if [ "$(uname -s)" = "Darwin" ]; then
        CLOUD_BACKUP_DIR="$HOME/Google Drive/Mi unidad/Backups/MT"
    else
        CLOUD_BACKUP_DIR="$HOME/backups/mt_memory_backups"
    fi
fi

mkdir -p "$CLOUD_BACKUP_DIR"
echo "☁️  Copiando a carpeta local/cloud ($CLOUD_BACKUP_DIR)..."
cp "$TEMP_BACKUP_PATH" "$CLOUD_BACKUP_DIR/"

# Mantener solo los últimos 7 backups
echo "🧹 Limpiando backups antiguos (manteniendo los últimos 7)..."
ls -tp "$CLOUD_BACKUP_DIR"/*.tar.gz | grep -v '/$' | tail -n +8 | xargs -I {} rm -- {} 2>/dev/null || true

# -----------------------------------------------------------------------
# Bloque 2: Backup a repositorio Git privado (si GIT_BACKUP_REPO está definida)
# -----------------------------------------------------------------------
if [ -n "$GIT_BACKUP_REPO" ]; then
    echo "🔐 Iniciando backup a repositorio Git privado..."

    GIT_BACKUP_WORKDIR="/tmp/mt_git_backup_workdir"

    # Clonar si no existe, hacer pull si ya existe
    if [ ! -d "$GIT_BACKUP_WORKDIR/.git" ]; then
        echo "  -> Clonando repositorio remoto por primera vez..."
        rm -rf "$GIT_BACKUP_WORKDIR"
        git clone "$GIT_BACKUP_REPO" "$GIT_BACKUP_WORKDIR"
    else
        echo "  -> Actualizando repo local..."
        git -C "$GIT_BACKUP_WORKDIR" pull --rebase --quiet
    fi

    # Copiar el backup al directorio del repo
    echo "  -> Copiando backup al repositorio..."
    cp "$TEMP_BACKUP_PATH" "$GIT_BACKUP_WORKDIR/"

    # Mantener solo los últimos 7 backups en el repo también
    ls -tp "$GIT_BACKUP_WORKDIR"/*.tar.gz 2>/dev/null | grep -v '/$' | tail -n +8 | xargs -I {} rm -- {} 2>/dev/null || true

    # Commit y push
    git -C "$GIT_BACKUP_WORKDIR" add -A
    git -C "$GIT_BACKUP_WORKDIR" commit -m "Backup ${DATE}" --quiet
    git -C "$GIT_BACKUP_WORKDIR" push --quiet

    echo "✅ Backup Git completado: $BACKUP_FILENAME → $GIT_BACKUP_REPO"
else
    echo "ℹ️  GIT_BACKUP_REPO no definida. Saltando backup a Git."
fi

# Limpiar archivo temporal
rm -f "$TEMP_BACKUP_PATH"

echo "✅ Backup completado con éxito: $BACKUP_FILENAME"
