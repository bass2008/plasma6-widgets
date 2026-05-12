#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WIDGET="sergey-plasma6-widget"
METADATA="$SCRIPT_DIR/$WIDGET/metadata.json"

if [[ ! -f "$METADATA" ]]; then
    echo "error: $METADATA is missing" >&2
    exit 1
fi

ID="$(grep -oP '"Id":\s*"\K[^"]+' "$METADATA")"
if [[ -z "$ID" ]]; then
    echo "error: could not parse Id from $METADATA" >&2
    exit 1
fi

if ! command -v kpackagetool6 >/dev/null 2>&1; then
    echo "error: kpackagetool6 is not installed" >&2
    exit 1
fi

if ! kpackagetool6 -t Plasma/Applet -l 2>/dev/null | grep -qx "$ID"; then
    echo "not installed: $ID — nothing to remove"
    exit 0
fi

echo "removing: $ID"
kpackagetool6 -t Plasma/Applet -r "$ID"
echo "done"
echo
echo "note: restart Plasma shell to refresh running instances:"
echo "  kquitapp6 plasmashell && kstart plasmashell"
