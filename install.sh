#!/usr/bin/env bash
set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

echo "Installing Homebrew packages..."
brew bundle --file "$DOTFILES/Brewfile"

echo "Stowing dotfiles..."

for pkg in "$DOTFILES/packages"/*; do
  pkg="$(basename "$pkg")"
  echo "Stowing $pkg"

  stow \
    --dir="$DOTFILES/packages" \
    --target="$HOME" \
    --restow \
    "$pkg"
done

cd "$DOTFILES"

echo "Installing rustup..."

if ! command -v rustup >/dev/null; then
  curl https://sh.rustup.rs -sSf | sh -s -- -y
fi

echo "Installing Rust toolchain..."
source "$HOME/.cargo/env"
rustup default stable

echo "Installing runtimes via mise..."
mise install

echo "Installing global npm tools..."
npm install -g typescript

echo "Configuring git hooks..."
git config --global core.hooksPath "$DOTFILES/hooks"

echo "Installation complete."
