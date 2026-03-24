#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/common.sh"

NAME="${1:?usage: status.sh <name>}"
STATUS="$(session_dir "$NAME")/status.json"
OUTPUT="$(session_dir "$NAME")/output.log"

if [[ ! -f "$STATUS" ]]; then
  echo "missing status: $STATUS" >&2
  exit 1
fi

jq . "$STATUS"
printf '\n== recent output ==\n'
tail -n 20 "$OUTPUT" 2>/dev/null || true
