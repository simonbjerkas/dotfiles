export HOMEBREW_INSTALL_CLEANUP=1
export GPG_TTY="$(tty)"

command -v fnm >/dev/null 2>&1 && eval "$(fnm env --use-on-cd --shell zsh)"

# zoxide
export _ZO_ECHO=1
export _ZO_MAXAGE=5000
export _ZO_DATA_DIR="$HOME/.local/share/zoxide"
export _ZO_EXCLUDE_DIRS="\
$HOME:$HOME/Downloads:/tmp/**:$HOME/.cache/**:\
**/node_modules/**:\
**/site-packages/**:**/dist-packages/**:\
**/.venv/**:**/venv/**:**/__pycache__/**:\
**/target/**:$HOME/.cargo/registry/**:\
**/vendor/**:\
**/.git/**:$HOME/Library/**"
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"

if [[ "$OS" == "macos" ]] && command -v brew >/dev/null 2>&1; then
  BREW_PREFIX="$(brew --prefix)"

  [[ -f "$BREW_PREFIX/opt/fzf/shell/completion.zsh" ]] &&
    source "$BREW_PREFIX/opt/fzf/shell/completion.zsh"

  [[ -f "$BREW_PREFIX/opt/fzf/shell/key-bindings.zsh" ]] &&
    source "$BREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
fi

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu no
zstyle ':completion:*' special-dirs true
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 -a --color=always $realpath'
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
