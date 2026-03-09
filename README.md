# dotfiles

Personal dotfiles for macOS, managed with GNU Stow.

## Structure

Configurations are grouped as Stow packages in `packages/`:

- `bin`
- `git`
- `misc`
- `zsh`
- `zshenv`

Zsh is structured like this:

- `~/.zshenv` sets `ZDOTDIR`
- `~/.config/zsh/.zshenv` defines environment variables
- `~/.config/zsh/.zshrc` loads interactive shell configuration

## Requirements

- macOS
- Homebrew

Most tools are installed through the included `Brewfile`.

## Installation

Clone the repo and run the installer:

```bash
git clone https://github.com/simonbjerkas/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

The install script will:

- install Homebrew if needed

- apply the Brewfile

- stow all packages into $HOME

- install and configure Rust

- start a fresh login shell

## Updating

To re-apply the configuration after changes:

```bash
cd ~/.dotfiles
./install.sh
```

## Notes

- Dotfiles are symlinked into $HOME using GNU Stow.

- Homebrew works on both Apple Silicon and Intel macOS.

- The Brewfile is maintained manually as a curated base setup.
