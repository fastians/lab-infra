#!/bin/bash
set -e

SERVICE_NAME="geoserver"
APP_DIR="/home/mateen_fastians/.apps/Defeaturing"
SERVICE_UNIT="geoserver.service"
PORT="8001"

BRANCH="${1:-main}"

echo "[DEPLOY] $SERVICE_NAME ($BRANCH)"

cd "$APP_DIR"

git fetch origin
git checkout "$BRANCH"
git pull origin "$BRANCH"

if [ ! -d ".venv" ]; then
    echo "[SETUP] Creating virtual environment..."
    python3 -m venv .venv
fi

source .venv/bin/activate
pip install -r requirements.txt

sudo systemctl restart "$SERVICE_UNIT"

for i in {1..10}; do
  curl -sf "http://127.0.0.1:${PORT}/health" && break
  sleep 1
done

echo "[DEPLOY OK] $SERVICE_NAME ($BRANCH)"
