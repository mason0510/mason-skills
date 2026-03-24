#!/usr/bin/env bash
set -euo pipefail

TS_ROOT="${TS_ROOT:-.runtime/terminal-supervisor}"
TS_PREFIX="${TS_PREFIX:-ts}"

session_dir() {
  local name="$1"
  printf '%s/%s\n' "$TS_ROOT" "$name"
}

tmux_name() {
  local name="$1"
  printf '%s-%s\n' "$TS_PREFIX" "$name"
}

ensure_session_dir() {
  local name="$1"
  mkdir -p "$(session_dir "$name")"
}

json_now() {
  date '+%Y-%m-%dT%H:%M:%S%z'
}
