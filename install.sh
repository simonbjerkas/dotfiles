#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

export CARGO_HOME="$HOME/.local/share/cargo"
export RUSTUP_HOME="$HOME/.local/share/rustup"

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
    printf "\r%s%s%s %s" \
      "$MAGENTA" "${frames[$i]}" "$RESET" "$message"
    i=$(( (i + 1) % ${#frames[@]} ))
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

run_step_shell() {
  local message="$1"
  local command="$2"

  run_step "$message" bash -lc "$command"
}

section "Preparing environment"

mkdir -p \
  "$HOME/.config" \
  "$HOME/.local/share" \
  "$HOME/.cache" \
  "$HOME/.local/state" \
  "$HOME/.local/bin"

success "Created base directories"

[[ -f "$DOTFILES/Brewfile" ]] || {
  error "Brewfile not found at $DOTFILES/Brewfile"
  exit 1
}

success "Found Brewfile"

section "Checking Homebrew"

if ! command -v brew >/dev/null 2>&1; then
  warn "Homebrew not found — installing it now"
  run_step_shell \
    "Installing Homebrew" \
    'curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | /bin/bash'
else
  success "Homebrew already installed"
fi

if [[ -x "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  info "Using Homebrew from /opt/homebrew"
elif [[ -x "/usr/local/bin/brew" ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
  info "Using Homebrew from /usr/local"
fi

command -v brew >/dev/null 2>&1 || {
  error "Homebrew is not available on PATH"
  exit 1
}

section "Applying Brewfile"
run_step \
  "Installing and syncing Homebrew packages" \
  brew \
  bundle \
  --file \
  "$DOTFILES/Brewfile"

command -v stow >/dev/null 2>&1 || {
  error "GNU Stow is not installed"
  exit 1
}

section "Stowing dotfiles"

for pkg_path in "$DOTFILES/packages"/*; do
  [[ -d "$pkg_path" ]] || continue
  pkg="$(basename "$pkg_path")"
  run_step \
    "Stowing package: $pkg" \
    stow \
    --dir="$DOTFILES/packages" \
    --target="$HOME" \
    --restow \
    "$pkg"
done

section "Ensuring Rust toolchain"

if ! command -v rustup >/dev/null 2>&1; then
  warn "rustup not found — installing it now"
  run_step_shell \
    "Installing rustup" \
    "curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | \
sh -s -- -y --no-modify-path"
else
  success "rustup already installed"
fi

if [[ -f "$CARGO_HOME/env" ]]; then
  # shellcheck disable=SC1090
  source "$CARGO_HOME/env"
  success "Loaded Rust environment"
else
  error "Rust env file not found at $CARGO_HOME/env"
  exit 1
fi

run_step "Setting default Rust toolchain to stable" rustup default stable

section "Finished"
success "Dotfiles installation complete"
info "Refresh the terminal with: exec zsh -l"
