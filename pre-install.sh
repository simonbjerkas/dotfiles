#!/usr/bin/env bash
set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

# Define custom paths consistently
export CARGO_HOME="$HOME/.local/share/cargo"
export RUSTUP_HOME="$HOME/.local/share/rustup"

# Install and source Homebrew
if ! command -v brew >/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# 3. INSTALL DEPENDENCIES
echo "Updating Homebrew packages..."
brew bundle --file "$DOTFILES/Brewfile"

# 4. STOW CONFIGS
echo "Stowing dotfiles..."
# Use git and stow which are now guaranteed to be there via brew bundle
for pkg in "$DOTFILES/packages"/*; do
  pkg="$(basename "$pkg")"
  stow --dir="$DOTFILES/packages" --target="$HOME" --restow "$pkg"
done

# 5. CONFIGURE RUST (THE RIGHT WAY)
echo "Ensuring Rust..."
if ! command -v rustup >/dev/null; then
  # Install to your CUSTOM path
  curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh -s -- -y --no-modify-path
fi

# Load the env from the CUSTOM path and set default
source "$CARGO_HOME/env"
rustup default stable

# 6. RE-LINK HOOKS
echo "Configuring git hooks..."
git config --global core.hooksPath "$DOTFILES/hooks"

echo "Installation complete! Refreshing shell..."
exec zsh -l
