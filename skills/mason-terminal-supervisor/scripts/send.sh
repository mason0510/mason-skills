#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/common.sh"

NAME="${1:?usage: send.sh <name> <note|exec|replace|interrupt|pause|resume|abort> [payload]}"
TYPE="${2:?type required}"
shift 2 || true
PAYLOAD="${*:-}"
ensure_session_dir "$NAME"
DIR="$(session_dir "$NAME")"
INBOX="$DIR/inbox.jsonl"

case "$TYPE" in
  note)
    jq -nc --arg type "$TYPE" --arg message "$PAYLOAD" --arg ts "$(json_now)" '{type:$type,message:$message,ts:$ts}' >> "$INBOX"
    ;;
  exec|replace)
    jq -nc --arg type "$TYPE" --arg command "$PAYLOAD" --arg ts "$(json_now)" '{type:$type,command:$command,ts:$ts}' >> "$INBOX"
    ;;
  interrupt|pause|resume|abort)
    jq -nc --arg type "$TYPE" --arg ts "$(json_now)" '{type:$type,ts:$ts}' >> "$INBOX"
    ;;
  *)
    echo "unsupported type: $TYPE" >&2
    exit 1
    ;;
esac

echo "queued $TYPE for $NAME"
