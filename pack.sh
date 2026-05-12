#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WIDGET="sergey-plasma6-widget"
SRC="$SCRIPT_DIR/$WIDGET"
OUT="$SCRIPT_DIR/$WIDGET.tar.gz"

if [[ ! -d "$SRC" ]]; then
    echo "error: widget source not found at $SRC" >&2
    exit 1
fi

if [[ ! -f "$SRC/metadata.json" ]]; then
    echo "error: $SRC/metadata.json is missing" >&2
    exit 1
fi

rm -f "$OUT"
tar -czf "$OUT" -C "$SRC" metadata.json contents/

echo "packed: $OUT"
tar -tzf "$OUT"
