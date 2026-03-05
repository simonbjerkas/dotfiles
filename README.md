# Dotfiles

Reproducible macOS development environment using:

- **GNU Stow** – dotfile management
- **Homebrew + Brewfile** – system packages
- **rustup** – Rust toolchains
- **mise** – Node and Python runtimes
- **Zsh + Powerlevel10k** – shell
- **XDG directories** – clean `$HOME`

---

# Setup

Clone and install:

```bash
git clone https://github.com/simonbjerkas/dotfiles ~/.dotfiles
cd ~/.dotfiles
```

and if on a new machine

```bash
./bootstrap.sh
```

else

```bash
./install.sh
```

