export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$XDG_DATA_HOME"
mkdir -p "$XDG_CACHE_HOME"
mkdir -p "$XDG_STATE_HOME"

# zsh history location
export HISTFILE="$XDG_STATE_HOME/zsh/history"
mkdir -p "$(dirname "$HISTFILE")"

# ensure local bin exists
mkdir -p "$HOME/.local/bin"
export PATH="$HOME/.local/bin:$PATH"
