#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")/.." && pwd)"
APT_PACKAGES_FILE="$DOTFILES/install/packages.apt"

# shellcheck disable=SC1091
source "$DOTFILES/install/common.sh"

section "Preparing environment"

mkdir -p \
  "$HOME/.config" \
  "$HOME/.local/share" \
  "$HOME/.cache" \
  "$HOME/.local/state" \
  "$HOME/.local/bin"

success "Created base directories"

[[ -f "$APT_PACKAGES_FILE" ]] || {
  error "APT package list not found at $APT_PACKAGES_FILE"
  exit 1
}

success "Found APT package list"

section "Checking package manager"

if ! command -v apt-get >/dev/null 2>&1; then
  error "This Linux installer currently supports apt-based systems only"
  exit 1
fi

success "apt-get is available"

section "Applying Linux package list"
run_step "Updating apt package index" sudo apt-get update
run_step \
  "Installing Linux dependencies" \
  sudo \
  xargs \
  -a \
  "$APT_PACKAGES_FILE" \
  apt-get \
  install \
  -y

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

section "Finished"
success "Dotfiles installation complete"
info "Refresh the terminal with: exec zsh -l"
