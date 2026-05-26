import asyncio
import json
import os
from pathlib import Path
import chromadb
from mcp.server.fastmcp import FastMCP

# --- Configuración ---
COLLECTION_NAME = "cyber_brain_memory"

# Cargar .env si existe (para no depender de python-dotenv como dep extra)
_env_file = Path(__file__).parent / ".env"
if _env_file.exists():
    for line in _env_file.read_text().splitlines():
        line = line.strip()
        if line and not line.startswith("#") and "=" in line:
            key, _, value = line.partition("=")
            os.environ.setdefault(key.strip(), value.strip())

# Modo de conexión: HTTP (remoto) o local (SQLite/archivo)
_chroma_host = os.environ.get("CHROMA_SERVER_HOST")
_chroma_port = int(os.environ.get("CHROMA_SERVER_PORT", "8000"))

if _chroma_host:
    print(f"🌐 Conectando a ChromaDB remoto en {_chroma_host}:{_chroma_port}")
    client = chromadb.HttpClient(host=_chroma_host, port=_chroma_port)
else:
    MEMORY_DIR = os.path.expanduser("~/.gemini/memory_db")
    print(f"💾 Usando ChromaDB local en {MEMORY_DIR}")
    client = chromadb.PersistentClient(path=MEMORY_DIR)

collection = client.get_or_create_collection(name=COLLECTION_NAME)

# Inicializar FastMCP
mcp = FastMCP("MT Semantic Memory")

@mcp.tool()
def store_memory(content: str, source: str = "direct_chat", tags: list[str] = None) -> str:
    """
    Store a piece of information in the long-term semantic memory.
    Use this to remember architectural decisions, bug fixes, or user preferences.
    """
    import hashlib
    import time
    
    # Generar un ID único basado en el contenido y el timestamp
    timestamp = str(time.time())
    memory_id = hashlib.sha256(f"{content}{timestamp}".encode()).hexdigest()[:16]
    
    metadata = {
        "source": source,
        "timestamp": timestamp
    }
    if tags:
        metadata["tags"] = ",".join(tags)
        
    collection.add(
        documents=[content],
        metadatas=[metadata],
        ids=[memory_id]
    )
    
    return f"Memory successfully stored with ID: {memory_id}"

@mcp.tool()
def search_memory(query: str, n_results: int = 3) -> str:
    """
    Search the long-term semantic memory for concepts, past decisions, or knowledge.
    Returns the most semantically relevant memories.
    """
    results = collection.query(
        query_texts=[query],
        n_results=n_results
    )
    
    if not results['documents'] or not results['documents'][0]:
        return "No relevant memories found for this query."
        
    formatted_results = []
    for i, doc in enumerate(results['documents'][0]):
        meta = results['metadatas'][0][i]
        source = meta.get('source', 'unknown')
        formatted_results.append(f"--- Result {i+1} (Source: {source}) ---\n{doc}\n")
        
    return "\n".join(formatted_results)

if __name__ == "__main__":
    mcp.run()
