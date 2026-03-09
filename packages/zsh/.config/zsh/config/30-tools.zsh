export HOMEBREW_INSTALL_CLEANUP=1

command -v mise >/dev/null && eval "$(mise activate zsh)"
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"

export GPG_TTY="$(tty)"

if command -v brew >/dev/null; then
  BREW_PREFIX="$(brew --prefix)"

  [[ -f "$BREW_PREFIX/opt/fzf/shell/completion.zsh" ]] &&
    source "$BREW_PREFIX/opt/fzf/shell/completion.zsh"

  [[ -f "$BREW_PREFIX/opt/fzf/shell/key-bindings.zsh" ]] &&
    source "$BREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
fi

autoload -Uz compinit
compinit

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true
