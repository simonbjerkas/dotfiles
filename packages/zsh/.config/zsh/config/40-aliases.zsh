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

# save me from mistyping
alias sl="ls"

# git
alias g="git"
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gm="git commit -m"
alias gp="git push"
alias gl="git pull"
alias gd="git diff"
alias gb="git branch"
alias gco="git checkout"

# update environment
alias update="brew update && brew upgrade && mise upgrade"

# reload shell
alias reload="exec zsh"
