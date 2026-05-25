#!/bin/bash
set -e

# Configuración
MEMORY_DIR="$HOME/.gemini/memory_db"
# Asumimos que Google Drive está en esta ruta. Cámbialo si tu ruta exacta a Drive es distinta.
CLOUD_BACKUP_DIR="$HOME/Google Drive/Mi unidad/Backups/MT"
DATE=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="mt_memory_${DATE}.tar.gz"
TEMP_BACKUP_PATH="/tmp/${BACKUP_FILE}"

echo "📦 Iniciando backup de la memoria semántica (ChromaDB)..."

if [ ! -d "$MEMORY_DIR" ]; then
    echo "⚠️  No se encontró la base de datos en $MEMORY_DIR. Abortando backup."
    exit 0
fi

# Crear carpeta destino si no existe
mkdir -p "$CLOUD_BACKUP_DIR"

# Comprimir la carpeta de memoria
echo "🗜️  Comprimiendo base de datos..."
tar -czf "$TEMP_BACKUP_PATH" -C "$(dirname "$MEMORY_DIR")" "$(basename "$MEMORY_DIR")"

# Mover a Google Drive
echo "☁️  Moviendo a la nube ($CLOUD_BACKUP_DIR)..."
mv "$TEMP_BACKUP_PATH" "$CLOUD_BACKUP_DIR/"

# Opcional: Mantener solo los últimos 7 backups para no llenar el Drive
echo "🧹 Limpiando backups antiguos (manteniendo los últimos 7 días)..."
ls -tp "$CLOUD_BACKUP_DIR"/*.tar.gz | grep -v '/$' | tail -n +8 | xargs -I {} rm -- {} 2>/dev/null || true

echo "✅ Backup completado con éxito: $BACKUP_FILE"
