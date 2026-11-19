#!/bin/bash
# Populates a private, per-user cache with remaining API usage for statusline.sh.
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/agy"
CACHE_FILE="$CACHE_DIR/usage_cache"
LOCK_DIR="$CACHE_DIR/usage.lock"

mkdir -p "$CACHE_DIR" || exit 1

if ! mkdir "$LOCK_DIR" 2>/dev/null; then
    lock_mtime=$(stat -f %m "$LOCK_DIR" 2>/dev/null || echo 0)
    lock_age=$(( $(date +%s) - lock_mtime ))
    if [ "$lock_age" -lt 300 ]; then
        exit 0
    fi
    rm -rf "$LOCK_DIR"
    mkdir "$LOCK_DIR" 2>/dev/null || exit 1
fi
trap 'rm -rf "$LOCK_DIR"' EXIT

export PATH="$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin:$PATH"
output=$(agy --print "/usage" 2>/dev/null)

five_h=$(echo "$output" | awk -F'Remaining' '/Gemini.*Five Hour/ {print $2}' | awk '{print $1}')
weekly=$(echo "$output" | awk -F'Remaining' '/Gemini.*Weekly/ {print $2}' | awk '{print $1}')

if [ -n "$five_h" ]; then
    umask 077
    printf '%s\n' "5h: $five_h - Sem: $weekly" > "$CACHE_FILE"
fi
