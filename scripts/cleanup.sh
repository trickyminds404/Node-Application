#!/usr/bin/env bash
set -euo pipefail

echo "[INFO] Removing dangling Docker images..."
docker image prune -f

echo "[INFO] Pruning unused containers and networks..."
docker system prune -f

echo "[✔] Docker cleanup complete."
