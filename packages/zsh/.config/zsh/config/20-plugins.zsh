if command -v brew >/dev/null; then
  BREW_PREFIX="$(brew --prefix)"

  [[ -f "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] &&
    source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

  [[ -f "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] &&
    source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

  [[ -f "$BREW_PREFIX/opt/powerlevel10k/share/powerlevel10k/powerlevel10k.zsh-theme" ]] &&
    source "$BREW_PREFIX/opt/powerlevel10k/share/powerlevel10k/powerlevel10k.zsh-theme"
fi
