#!/usr/bin/env bash

set -euo pipefail

URL="${1:-http://localhost:8080}"

echo "======================================"
echo "          HEALTH CHECK"
echo "======================================"

echo "Target URL: $URL"
echo ""

if ! command -v curl >/dev/null 2>&1; then
    echo "ERROR: curl is not installed." >&2
    exit 1
fi

echo "Checking server availability..."

if HTTP_STATUS=$(curl --silent --show-error --output /dev/null \
    --write-out '%{http_code}' \
    --connect-timeout 5 \
    --max-time 10 \
    "$URL"); then

    if [[ "$HTTP_STATUS" == "200" ]]; then
        echo "PASS: Server returned HTTP 200."
        echo "Health check successful."
        exit 0
    fi

    echo "FAIL: Expected HTTP 200, received HTTP $HTTP_STATUS." >&2
else
    echo "FAIL: Unable to reach $URL." >&2
fi

echo ""
echo "DIAGNOSTICS"
echo "Attempting detailed connection check..."

curl --verbose --max-time 10 "$URL" || true

echo ""
echo "Health check failed."
exit 1