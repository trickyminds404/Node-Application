#!/usr/bin/env bash
set -euo pipefail

echo "[INFO] Starting Docker build and push process..."
GIT_COMMIT=$(git rev-parse --short HEAD)
IMAGE="nageshdocker25/myapp:$GIT_COMMIT"

echo "[INFO] Building image: $IMAGE"
DOCKER_BUILDKIT=0 docker build -t "$IMAGE" .

echo "[INFO] Logging into Docker Hub..."
docker login

echo "[INFO] Pushing image to Docker Hub..."
docker push "$IMAGE"

echo "[✔] Docker image pushed: $IMAGE"
