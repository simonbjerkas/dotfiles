#!/usr/bin/env bash

if [[ -t 1 ]]; then
  BOLD="$(tput bold)"
  DIM="$(tput dim)"
  RED="$(tput setaf 1)"
  GREEN="$(tput setaf 2)"
  YELLOW="$(tput setaf 3)"
  BLUE="$(tput setaf 4)"
  MAGENTA="$(tput setaf 5)"
  CYAN="$(tput setaf 6)"
  RESET="$(tput sgr0)"
else
  BOLD=""
  DIM=""
  RED=""
  GREEN=""
  YELLOW=""
  BLUE=""
  MAGENTA=""
  CYAN=""
  RESET=""
fi

info() {
  printf "%s→%s %s\n" "$BLUE" "$RESET" "$1"
}

success() {
  printf "%s✓%s %s\n" "$GREEN" "$RESET" "$1"
}

warn() {
  printf "%s!%s %s\n" "$YELLOW" "$RESET" "$1"
}

error() {
  printf "%s✗%s %s\n" "$RED" "$RESET" "$1" >&2
}

section() {
  printf "\n%s==>%s %s%s%s\n" "$BOLD" "$RESET" "$CYAN" "$1" "$RESET"
}

format_duration() {
  local total="$1"
  local minutes=$((total / 60))
  local seconds=$((total % 60))

  if (( minutes > 0 )); then
    printf "%dm%02ds" "$minutes" "$seconds"
  else
    printf "%ds" "$seconds"
  fi
}

spinner() {
  local pid="$1"
  local message="$2"
  local delay=0.1
  local frames=('⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏')
  local i=0

  while kill -0 "$pid" 2>/dev/null; do
    printf "\r%s%s%s %s" "$MAGENTA" "${frames[$i]}" "$RESET" "$message"
    i=$(((i + 1) % ${#frames[@]}))
    sleep "$delay"
  done

  printf "\r\033[K"
}

run_step() {
  local message="$1"
  shift

  local log_file start_time end_time duration
  log_file="$(mktemp)"
  start_time="$(date +%s)"

  "$@" >"$log_file" 2>&1 &
  local pid=$!

  spinner "$pid" "$message"

  if wait "$pid"; then
    end_time="$(date +%s)"
    duration="$((end_time - start_time))"
    success "$message ${DIM}($(format_duration "$duration"))${RESET}"
    rm -f "$log_file"
  else
    end_time="$(date +%s)"
    duration="$((end_time - start_time))"
    error "$message ${DIM}($(format_duration "$duration"))${RESET}"
    printf "%sCommand failed:%s " "$DIM" "$RESET" >&2
    printf "%q " "$@" >&2
    printf "\n\n" >&2
    cat "$log_file" >&2
    rm -f "$log_file"
    exit 1
  fi
}
