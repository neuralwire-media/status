#!/usr/bin/env bash
# ==============================================================================
# Automated SQLite Backup Script for Neuralwire Status (Uptime Kuma)
# ==============================================================================
set -euo pipefail

BACKUP_DIR="${BACKUP_DIR:-./backups}"
CONTAINER_NAME="neuralwire-status"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
TARGET_FILE="${BACKUP_DIR}/kuma_backup_${TIMESTAMP}.sqlite"

mkdir -p "${BACKUP_DIR}"

echo "[INFO] Starting database backup for container: ${CONTAINER_NAME}..."

if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  echo "[ERROR] Container '${CONTAINER_NAME}' is not running."
  exit 1
fi

docker cp "${CONTAINER_NAME}:/app/data/kuma.db" "${TARGET_FILE}"

echo "[SUCCESS] Backup created at: ${TARGET_FILE} ($(du -h "${TARGET_FILE}" | cut -f1))"

# Prune backups older than 30 days
find "${BACKUP_DIR}" -name "kuma_backup_*.sqlite" -mtime +30 -delete 2>/dev/null || true
echo "[INFO] Pruned backups older than 30 days."
