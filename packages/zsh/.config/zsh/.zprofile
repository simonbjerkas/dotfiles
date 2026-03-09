typeset -U path PATH

path=(
  "$HOME/.local/bin"
  "$XDG_DATA_HOME/cargo/bin"
  $path
)

export PATH
