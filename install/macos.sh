#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")/.." && pwd)"

# shellcheck disable=SC1091
source "$DOTFILES/install/common.sh"

export CARGO_HOME="$HOME/.local/share/cargo"
export RUSTUP_HOME="$HOME/.local/share/rustup"

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

BREWFILE="$DOTFILES/install/Brewfile"

[[ -f "$BREWFILE" ]] || {
  warn "Brewfile not found at $BREWFILE"
  exit 1
}

success "Found Brewfile"

section "Checking Homebrew"

if ! command -v brew >/dev/null 2>&1; then
  warn "Homebrew not found — installing it now"
  run_step_shell \
    "Installing Homebrew" \
    "curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | /bin/bash"
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
  brew bundle --file "$BREWFILE"

command -v stow >/dev/null 2>&1 || {
  error "GNU Stow is not installed"
  exit 1
}

command -v bob >/dev/null 2>&1 || {
  error "bob version manager is not installed"
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

section "Ensuring Neovim setup"

if ! command -v nvim >/dev/null 2>&1; then
  warn "nvim not installed - installing it now"
  run_step_shell \
    "Installing neovim" \
    bob install stable && bob use nightly
else
  success "neovim already installed"
fi

section "Ensuring Rust toolchain"
if ! command -v rustup >/dev/null 2>&1; then
  warn "rustup not found — installing it now"
  run_step_shell \
    "Installing rustup" \
    "curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh -s -- -y --no-modify-path"
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
run_step "Adding Rust components" rustup component add rustfmt rust-analyzer clippy

section "Installing Python tools"
run_step "Installing ruff via uv" uv tool install ruff basedpyright

section "Finished"
success "Dotfiles installation complete"
info "Refresh the terminal with: exec zsh -l"
