#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
OS="$(uname -s)"

case "$OS" in
  Darwin)
    exec "$DOTFILES/install/macos.sh"
    ;;
  Linux)
    exec "$DOTFILES/install/linux.sh"
    ;;
  *)
    echo "Unsupported OS: $OS"
    exit 1
    ;;
esac
