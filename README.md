# dotfiles

Personal dotfiles managed with GNU Stow.

## Platform support

- macOS: full setup for personal machines
- Linux: minimal setup for SSH sessions, VMs, and containers

Linux support currently targets apt-based systems.

## Structure

Configurations are organized as Stow packages under `packages/`:

- `bin`
- `git`
- `misc`
- `zsh`
- `zshenv`

Zsh is structured like this:

- `~/.zshenv` sets `ZDOTDIR`
- `~/.config/zsh/.zshenv` defines environment variables
- `~/.config/zsh/.zshrc` loads interactive shell configuration

## Installation

Clone the repo and run the installer:

```bash
git clone https://github.com/simonbjerkas/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

The installer will detect the platform automatically:

- macOS
    - installs Homebrew if needed
    - applies the Brewfile
    - stows all packages
    - install and configures Rust
- Linux
    - supports apt-based systems
    - installs a minimal set of CLI tools
    - stows all packages

## Updating

To re-apply the configuration after changes:

```bash
cd ~/.dotfiles
./install.sh
```

## Notes

- Dotfiles are symlinked into `$HOME` using GNU Stow
- The macOS `Brewfile` is maintained manually as a curated base setup.
- Zsh plugins are vendored in the repo
- Powerlevel10k is enabled on macOS only
- Linux is intentionally kept minimal and remote-firendly.

