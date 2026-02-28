#!/usr/bin/env bash
# ──────────────────────────────────────────────
# NutricIA — Dev Script
# Quick start for the development environment
# ──────────────────────────────────────────────
set -euo pipefail

echo "🌱 Starting NutricIA development stack..."
echo ""

# Check if .env exists
if [ ! -f .env ]; then
    echo "⚠ No .env found. Running setup first..."
    bash scripts/setup.sh
fi

# Start everything
docker compose up --build "$@"
