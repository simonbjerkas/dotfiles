export HOMEBREW_INSTALL_CLEANUP=1
export GPG_TTY="$(tty)"

command -v mise >/dev/null 2>&1 && eval "$(mise activate zsh)"
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"

if [[ "$OS" == "macos" ]] && command -v brew >/dev/null 2>&1; then
  BREW_PREFIX="$(brew --prefix)"

  [[ -f "$BREW_PREFIX/opt/fzf/shell/completion.zsh" ]] &&
    source "$BREW_PREFIX/opt/fzf/shell/completion.zsh"

  [[ -f "$BREW_PREFIX/opt/fzf/shell/key-bindings.zsh" ]] &&
    source "$BREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
fi

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true
