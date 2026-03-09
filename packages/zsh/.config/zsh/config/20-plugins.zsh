case "$(uname -s)" in
  Darwin) OS="macos" ;;
  Linux) OS="linux" ;;
  *) OS="unknown" ;;
esac

[[ -f "$ZDOTDIR/vendor/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] &&
  source "$ZDOTDIR/vendor/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

[[ -f "$ZDOTDIR/vendor/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] &&
  source "$ZDOTDIR/vendor/zsh-autosuggestions/zsh-autosuggestions.zsh"

if [[ "$OS" == "macos" ]]; then
  [[ -f "$ZDOTDIR/vendor/powerlevel10k/powerlevel10k.zsh-theme" ]] &&
    source "$ZDOTDIR/vendor/powerlevel10k/powerlevel10k.zsh-theme"
fi
