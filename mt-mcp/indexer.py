import os
import hashlib
import sqlite3
import glob
import chromadb

# Configuración
FOAM_DIR = "/Users/lucha/cyber-brain"
MEMORY_DIR = os.path.expanduser("~/.gemini/memory_db")
COLLECTION_NAME = "cyber_brain_memory"
STATE_DB = os.path.expanduser("~/.gemini/memory_db/indexer_state.db")

# Inicializar ChromaDB
client = chromadb.PersistentClient(path=MEMORY_DIR)
collection = client.get_or_create_collection(name=COLLECTION_NAME)

def init_state_db():
    """Inicializa la base de datos local (SQLite) para guardar hashes de archivos y no reindexar a lo tonto."""
    conn = sqlite3.connect(STATE_DB)
    c = conn.cursor()
    c.execute('''CREATE TABLE IF NOT EXISTS file_hashes (filepath TEXT PRIMARY KEY, hash TEXT)''')
    conn.commit()
    return conn

def get_file_hash(filepath):
    """Calcula el hash SHA256 de un archivo."""
    hasher = hashlib.sha256()
    try:
        with open(filepath, 'rb') as f:
            buf = f.read()
            hasher.update(buf)
        return hasher.hexdigest()
    except Exception:
        return None

def main():
    print(f"🧠 Iniciando indexación de Cyber Brain en: {FOAM_DIR}")
    
    if not os.path.exists(MEMORY_DIR):
        os.makedirs(MEMORY_DIR)
        
    conn = init_state_db()
    c = conn.cursor()
    
    # Buscar todos los archivos markdown en la carpeta Foam
    md_files = glob.glob(os.path.join(FOAM_DIR, "**/*.md"), recursive=True)
    
    updated_count = 0
    for filepath in md_files:
        current_hash = get_file_hash(filepath)
        if not current_hash:
            continue
            
        c.execute("SELECT hash FROM file_hashes WHERE filepath=?", (filepath,))
        row = c.fetchone()
        
        # Si el archivo es nuevo o cambió su hash, lo indexamos en ChromaDB
        if row is None or row[0] != current_hash:
            print(f"🔄 Indexando: {os.path.basename(filepath)}")
            
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()
                
            # Usar el path relativo como ID en ChromaDB para poder actualizarlo fácilmente
            rel_path = os.path.relpath(filepath, FOAM_DIR)
            
            # Upsert inserta o actualiza si ya existe el ID
            collection.upsert(
                documents=[content],
                metadatas=[{"source": f"foam:{rel_path}", "type": "markdown_note"}],
                ids=[f"foam_{rel_path}"]
            )
            
            # Guardar el nuevo hash
            c.execute("INSERT OR REPLACE INTO file_hashes (filepath, hash) VALUES (?, ?)", (filepath, current_hash))
            updated_count += 1
            
    conn.commit()
    conn.close()
    print(f"✅ Indexación completada. {updated_count} archivos actualizados en ChromaDB.")

if __name__ == "__main__":
    main()
