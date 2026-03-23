# safer and better defaults
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias mkdir="mkdir -p"
alias df="df -h"

# modern replacements
alias ls='eza'
alias ll='eza -lah --group-directories-first --git'
alias la='eza -a --group-directories-first'
alias lt='eza --tree --level=2 --group-directories-first'

alias fd='fd --color=always'

alias cat="bat"

# navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# zoxide
alias za='zoxide add'
alias zq='zoxide query'
alias zr='zoxide remove'

# ide
alias vi="nvim"
alias vim="nvim"

# save me from mistyping
alias sl="ls"

# update environment
alias update="brew update && brew upgrade && mise upgrade"

# reload shell
alias reload="exec zsh"
