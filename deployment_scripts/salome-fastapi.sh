#!/bin/bash
set -e

SERVICE_NAME="salome-fastapi"
APP_DIR="/home/mateen_fastians/opt/MEK_LAB_SALOME/app"
SERVICE_UNIT="salome-fastapi.service"
PORT="8000"
BRANCH="${1:-main}"

echo "[DEPLOY] $SERVICE_NAME ($BRANCH)"

cd "$APP_DIR"
git fetch origin
git checkout "$BRANCH"
git pull

if [ ! -d ".venv" ]; then
    echo "[SETUP] Creating virtual environment..."
    python3 -m venv .venv
fi

source .venv/bin/activate
timeout 300 pip install -r requirements.txt --no-input --quiet

sudo systemctl restart "$SERVICE_UNIT"

for i in {1..10}; do
  curl -sf "http://127.0.0.1:${PORT}/health" && break
  sleep 1
done

echo "[DEPLOY OK] $SERVICE_NAME"
