# Auto-start tmux — must run before p10k hijacks the terminal
if command -v tmux &>/dev/null && [[ -z "$TMUX" ]]; then
  tmux attach 2>/dev/null || tmux new -s main
fi

# Powerlevel10k instant prompt (must stay near top)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Zinit setup
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Rest of config
ZSH_CONFIG_DIR="${ZDOTDIR}/config"

for file in "$ZSH_CONFIG_DIR"/*.zsh(.N); do
  source "$file"
done

if [[ "$(uname -s)" == "Darwin" && -f "${ZDOTDIR}/.p10k.zsh" ]]; then
  source "${ZDOTDIR}/.p10k.zsh"
fi
