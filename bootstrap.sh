#!/usr/bin/env bash
set -e

DOTFILES_DIR="$HOME/.dotfiles"
REPO_URL="https://github.com/simonbjerkas/dotfiles.git"

echo "Checking for Homebrew..."

if ! command -v brew >/dev/null; then
  echo "Installing Homebrew..."

  /bin/bash -c \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "Installing bootstrap dependencies..."
brew install git stow

if [ ! -d "$DOTFILES_DIR" ]; then
  echo "Cloning dotfiles..."

  git clone "$REPO_URL" "$DOTFILES_DIR"
fi

cd "$DOTFILES_DIR"

echo "Running install script..."
./install.sh
