#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/common.sh"

NAME="${1:?usage: capture.sh <name>}"
TMUX_SESSION="$(tmux_name "$NAME")"

tmux capture-pane -pt "$TMUX_SESSION" -S -120
