#!/bin/bash
set -e

SERVICE_NAME="llmserver"
APP_DIR="/home/mateen_fastians/.apps/MEK_LAB_LLM_AGENT"
SERVICE_UNIT="llmserver.service"
PORT="8002"
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

# Use venv pip explicitly (avoids PEP 668 externally-managed-environment); repo has app/ subdir
timeout 300 .venv/bin/pip install -r app/requirements.txt --no-input --quiet

sudo systemctl restart "$SERVICE_UNIT"

for i in {1..10}; do
  curl -sf "http://127.0.0.1:${PORT}/health" && break
  sleep 1
done

echo "[DEPLOY OK] $SERVICE_NAME"
