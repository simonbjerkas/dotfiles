# Powerlevel10k
if [[ "$OS" == "macos" ]]; then
  zinit ice depth=1
  zinit light romkatv/powerlevel10k
fi

# zsh plugins
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# Load completions
autoload -U compinit && compinit
