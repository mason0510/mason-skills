#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/common.sh"

NAME="${1:?usage: start.sh <name> [initial-command]}"
shift || true
INITIAL_CMD="${*:-}"
ensure_session_dir "$NAME"
TMUX_SESSION="$(tmux_name "$NAME")"

if tmux has-session -t "$TMUX_SESSION" 2>/dev/null; then
  echo "session already exists: $TMUX_SESSION"
  exit 1
fi

tmux new-session -d -s "$TMUX_SESSION" "cd $(printf %q "$PWD") && $(printf %q "$SCRIPT_DIR/worker.sh") $(printf %q "$NAME") $(printf %q "$PWD")"
echo "started $TMUX_SESSION"

if [[ -n "$INITIAL_CMD" ]]; then
  "$SCRIPT_DIR/send.sh" "$NAME" exec "$INITIAL_CMD" >/dev/null
fi
