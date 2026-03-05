# Brew autocleanup
export HOMEBREW_INSTALL_CLEANUP=1
export HOMEBREW_NO_INSTALL_CLEANUP=0

# activate mise
eval "$(mise activate zsh)"

# smart cd
eval "$(zoxide init zsh)"

# gpg support
export GPG_TTY=$(tty)

# fzf integration
if command -v fzf >/dev/null; then
  source "$(brew --prefix)/opt/fzf/shell/completion.zsh"
  source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
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
