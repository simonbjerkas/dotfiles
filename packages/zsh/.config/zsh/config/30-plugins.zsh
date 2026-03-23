# Powerlevel10k
if [[ "$OS" == "macos" ]]; then
  zinit ice depth=1
  zinit light romkatv/powerlevel10k
fi

# Add in snippets
zinit snippet OMZP::command-not-found
zinit snippet OMZP::git

# zsh plugins
zinit light MichaelAquilina/zsh-you-should-use
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q
