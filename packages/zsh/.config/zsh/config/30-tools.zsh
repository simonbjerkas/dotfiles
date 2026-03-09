# Brew autocleanup
export HOMEBREW_INSTALL_CLEANUP=1

# activate mise
eval "$(mise activate zsh)"

# smart cd
eval "$(zoxide init zsh)"

# gpg support
export GPG_TTY="$(tty)"

# fzf integration
if command -v brew >/dev/null; then
  BREW_PREFIX="$(brew --prefix)"

  [[ -f "$BREW_PREFIX/opt/fzf/shell/completion.zsh" ]] &&
    source "$BREW_PREFIX/opt/fzf/shell/completion.zsh"

  [[ -f "$BREW_PREFIX/opt/fzf/shell/key-bindings.zsh" ]] &&
    source "$BREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
fi

# completion system
autoload -Uz compinit
compinit

# case‑insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# start menu selection immediately
zstyle ':completion:*' menu select

# allow completing . and ..
zstyle ':completion:*' special-dirs true
