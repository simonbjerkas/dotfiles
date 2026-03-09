# Powerlevel10k instant prompt (must stay near top)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_CONFIG_DIR="${ZDOTDIR}/config"

for file in "$ZSH_CONFIG_DIR"/*.zsh(.N); do
  source "$file"
done

if [[ "$(uname -s)" == "Darwin" && -f "${ZDOTDIR}/.p10k.zsh" ]]; then
  source "${ZDOTDIR}/.p10k.zsh"
fi
