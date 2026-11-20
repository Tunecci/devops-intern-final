#!/usr/bin/env bash

set -euo pipefail

echo "======================================"
echo "       SYSTEM INFORMATION REPORT"
echo "======================================"

echo ""
echo "USER INFORMATION"
echo "Username: $(id -un)"
echo "Real User ID: $(id -ru)"
echo "Effective User ID: $(id -u)"

echo ""
echo "HOST INFORMATION"
echo "Hostname: $(hostname)"
echo "Kernel: $(uname -r)"
echo "Date: $(date --iso-8601=seconds)"

echo ""
echo "DISK USAGE"
df -h /

echo ""
echo "MEMORY USAGE"
free -h

echo ""
echo "DOCKER STATUS"

if ! command -v docker >/dev/null 2>&1; then
    echo "Docker: Not installed"
elif docker info >/dev/null 2>&1; then
    echo "Docker daemon: Running"
else
    echo "Docker daemon: Not running or inaccessible"
fi

echo ""
echo "======================================"
echo "       SYSTEM REPORT COMPLETE"
echo "======================================"