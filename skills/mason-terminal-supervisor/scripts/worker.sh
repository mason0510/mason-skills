#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/common.sh"

NAME="${1:?session name required}"
WORKDIR="${2:-$(pwd)}"
ensure_session_dir "$NAME"
DIR="$(session_dir "$NAME")"
INBOX="$DIR/inbox.jsonl"
STATUS="$DIR/status.json"
OUTPUT="$DIR/output.log"
CURSOR="$DIR/cursor"
PID_FILE="$DIR/current.pid"
CMD_FILE="$DIR/current.command"

: > "$INBOX"
: > "$OUTPUT"
printf '0\n' > "$CURSOR"

current_pid=""
current_cmd=""
paused="false"
last_note="ready"
last_result=""

write_status() {
  local state="$1"
  local queue_size
  queue_size=$(wc -l < "$INBOX" | tr -d ' ')
  jq -n \
    --arg name "$NAME" \
    --arg state "$state" \
    --arg tmux_session "$(tmux_name "$NAME")" \
    --arg workdir "$WORKDIR" \
    --arg current_command "$current_cmd" \
    --arg current_pid "$current_pid" \
    --arg paused "$paused" \
    --arg last_note "$last_note" \
    --arg last_result "$last_result" \
    --arg updated_at "$(json_now)" \
    --arg output_log "$OUTPUT" \
    --arg inbox "$INBOX" \
    --argjson queue_size "${queue_size:-0}" \
    '{name:$name,state:$state,tmux_session:$tmux_session,workdir:$workdir,current_command:$current_command,current_pid:$current_pid,paused:($paused=="true"),last_note:$last_note,last_result:$last_result,updated_at:$updated_at,queue_size:$queue_size,output_log:$output_log,inbox:$inbox}' > "$STATUS"
}

log_line() {
  local msg="$1"
  printf '[%s] %s\n' "$(date '+%H:%M:%S')" "$msg" | tee -a "$OUTPUT"
}

start_command() {
  local cmd="$1"
  current_cmd="$cmd"
  paused="false"
  last_result=""
  printf '%s\n' "$cmd" > "$CMD_FILE"
  log_line "exec> $cmd"
  bash -lc "$cmd" 2>&1 | tee -a "$OUTPUT" &
  current_pid="$!"
  printf '%s\n' "$current_pid" > "$PID_FILE"
  write_status "running"
}

stop_current() {
  local signal="${1:-TERM}"
  if [[ -n "$current_pid" ]] && kill -0 "$current_pid" 2>/dev/null; then
    kill "-$signal" "$current_pid" 2>/dev/null || kill -s "$signal" "$current_pid" 2>/dev/null || true
    sleep 0.2
    kill -0 "$current_pid" 2>/dev/null && kill -KILL "$current_pid" 2>/dev/null || true
    log_line "signal> $signal pid=$current_pid"
  fi
}

handle_event() {
  local line="$1"
  local type
  type=$(jq -r '.type // empty' <<<"$line")
  case "$type" in
    note)
      last_note=$(jq -r '.message // ""' <<<"$line")
      log_line "note> $last_note"
      ;;
    exec)
      local cmd
      cmd=$(jq -r '.command // ""' <<<"$line")
      if [[ -n "$current_pid" ]] && kill -0 "$current_pid" 2>/dev/null; then
        last_note="busy; exec ignored"
        log_line "skip> busy, ignored exec"
      else
        start_command "$cmd"
      fi
      ;;
    replace)
      local cmd
      cmd=$(jq -r '.command // ""' <<<"$line")
      stop_current TERM
      current_pid=""
      start_command "$cmd"
      ;;
    interrupt)
      last_note="interrupt requested"
      stop_current INT
      current_pid=""
      current_cmd=""
      paused="false"
      write_status "idle"
      ;;
    pause)
      if [[ -n "$current_pid" ]] && kill -0 "$current_pid" 2>/dev/null; then
        kill -STOP "$current_pid" 2>/dev/null || true
        paused="true"
        last_note="paused"
        log_line "pause> pid=$current_pid"
      fi
      ;;
    resume)
      if [[ -n "$current_pid" ]] && kill -0 "$current_pid" 2>/dev/null; then
        kill -CONT "$current_pid" 2>/dev/null || true
        paused="false"
        last_note="resumed"
        log_line "resume> pid=$current_pid"
      fi
      ;;
    abort)
      last_note="abort requested"
      stop_current TERM
      write_status "aborted"
      log_line "abort> worker exit"
      exit 0
      ;;
    *)
      log_line "warn> unknown event: $line"
      ;;
  esac
}

cd "$WORKDIR"
log_line "worker> session=$NAME workdir=$WORKDIR"
write_status "idle"

while true; do
  if [[ -n "$current_pid" ]]; then
    if kill -0 "$current_pid" 2>/dev/null; then
      write_status "paused"
      [[ "$paused" == "false" ]] && write_status "running"
    else
      wait "$current_pid" || true
      last_result="finished"
      log_line "done> $current_cmd"
      current_pid=""
      current_cmd=""
      paused="false"
      write_status "idle"
    fi
  else
    write_status "idle"
  fi

  processed=$(cat "$CURSOR")
  total=$(wc -l < "$INBOX" | tr -d ' ')
  if (( total > processed )); then
    while IFS= read -r line; do
      [[ -z "$line" ]] && continue
      handle_event "$line"
    done < <(sed -n "$((processed + 1)),${total}p" "$INBOX")
    printf '%s\n' "$total" > "$CURSOR"
  fi

  sleep 1
done
