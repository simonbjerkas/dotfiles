[[ "$OSTYPE" == darwin* ]] && OS="macos" || OS="linux"

# Restore blinking bar cursor at every prompt (survives app exit, e.g. nvim resetting it)
_cursor_blinking_bar() { printf '\e[5 q'; }
autoload -Uz add-zsh-hook
add-zsh-hook precmd _cursor_blinking_bar

# Initialize Homebrew
if [[ -x "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x "/usr/local/bin/brew" ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
