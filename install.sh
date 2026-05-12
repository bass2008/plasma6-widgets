#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WIDGET="sergey-plasma6-widget"
ARCHIVE="$SCRIPT_DIR/$WIDGET.tar.gz"

if ! command -v kpackagetool6 >/dev/null 2>&1; then
    echo "error: kpackagetool6 is not installed" >&2
    exit 1
fi

echo "[1/2] packing widget"
"$SCRIPT_DIR/pack.sh" >/dev/null
echo "  packed: $ARCHIVE"

echo "[2/2] installing into Plasma"
if kpackagetool6 -t Plasma/Applet -l 2>/dev/null | grep -qx "$WIDGET"; then
    kpackagetool6 -t Plasma/Applet -u "$ARCHIVE"
else
    kpackagetool6 -t Plasma/Applet -i "$ARCHIVE"
fi

echo
echo "done. restart Plasma shell to pick up changes:"
echo "  kquitapp6 plasmashell && kstart plasmashell"
