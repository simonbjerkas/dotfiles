# activate mise
eval "$(mise activate zsh)"

# zoxide (smart cd)
eval "$(zoxide init zsh)"

# fzf integration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
