#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

export CARGO_HOME="$HOME/.local/share/cargo"
export RUSTUP_HOME="$HOME/.local/share/rustup"

mkdir -p \
  "$HOME/.config" \
  "$HOME/.local/share" \
  "$HOME/.cache" \
  "$HOME/.local/state" \
  "$HOME/.local/bin"

if ! command -v brew >/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(
    curl -fsSL \
      https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
  )"
fi

if [[ -x "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x "/usr/local/bin/brew" ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

command -v brew >/dev/null || {
  echo "Homebrew is not available on PATH"
  exit 1
}

echo "Updating Homebrew packages..."
brew bundle --file "$DOTFILES/Brewfile"

command -v stow >/dev/null || {
  echo "GNU Stow is not installed"
  exit 1
}

echo "Stowing dotfiles..."
for pkg_path in "$DOTFILES/packages"/*; do
  [[ -d "$pkg_path" ]] || continue
  pkg="$(basename "$pkg_path")"
  stow --dir="$DOTFILES/packages" --target="$HOME" --restow "$pkg"
done

echo "Ensuring Rust..."
if ! command -v rustup >/dev/null; then
  curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf |
    sh -s -- -y --no-modify-path
fi

if [[ -f "$CARGO_HOME/env" ]]; then
  # shellcheck disable=SC1090
  source "$CARGO_HOME/env"
else
  echo "Rust env file not found at $CARGO_HOME/env"
  exit 1
fi

rustup default stable

echo "Installation complete! Refreshing shell..."
exec zsh -l
