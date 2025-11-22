# Dotfiles Configuration

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Overview

This repository contains configuration files for various tools and shells, organized into packages that can be selectively installed using GNU Stow.

## Prerequisites

- **GNU Stow**: Install with your package manager
  - macOS: `brew install stow`
  - Linux: `sudo apt-get install stow` (or your distro's package manager)

## Installation

### Quick Install

```bash
cd ~/dotfiles
./install.sh
```

This will create symlinks from the repository to your home directory for all packages.

### Manual Installation

You can also install packages individually:

```bash
cd ~/dotfiles
stow -t ~ shell    # Install shell configs (.bashrc, .zshrc, etc.)
stow -t ~ git      # Install git config
stow -t ~ k8s      # Install Kubernetes aliases
# ... etc
```

## Uninstallation

### Quick Uninstall

```bash
cd ~/dotfiles
./uninstall.sh
```

### Manual Uninstall

```bash
cd ~/dotfiles
stow -D -t ~ shell    # Remove shell configs
stow -D -t ~ git      # Remove git config
# ... etc
```

## Package Structure

Each directory is a Stow "package" that gets symlinked to your home directory:

- **`shell/`** - Shell configuration files (`.bash_profile`, `.bashrc`, `.zshrc`)
- **`git/`** - Git configuration and hooks
  - `.gitconfig` - Main git config with conditional includes
  - `.gitconfig.personal` - Personal git settings
  - `.gitconfig.lightspeed` - Work-specific git settings
  - `hooks/` - Git hooks (e.g., `prepare-commit-msg` for JIRA integration)
- **`k8s/`** - Kubernetes aliases and functions (`kc`, `kcctx`, `kcns`)
- **`terraform/`** - Terraform alias (`tf`)
- **`telepresence/`** - Telepresence alias (`tp`)
- **`lightspeed/`** - Work-specific functions (Vault, Jinn/Gaia commands)
- **`general/`** - General utilities (IDE launchers)
- **`brew/`** - Homebrew installation script (not stowed, run manually)

## How It Works

GNU Stow creates symlinks from files in package directories to your home directory. For example:

- `shell/.bashrc` → `~/.bashrc`
- `git/.gitconfig` → `~/.gitconfig`
- `git/hooks/prepare-commit-msg` → `~/.git/hooks/prepare-commit-msg`

The actual files remain in this repository, and Stow manages the symlinks.

## Git Configuration

The git configuration uses Git's conditional `includeIf` feature:

- **Default** (all repos): Uses `git/.gitconfig.personal`
- **`~/Repositories/`**: Uses `git/.gitconfig.lightspeed` (work config)
- **`~/Repositories/personal/`**: Overrides back to personal config

This allows different git user settings based on repository location.

## Shell Functions

Shell functions are loaded from `.functions` files in each package directory. The `.bashrc` file sources these automatically if they exist:

- `git/.functions` - Git helper functions
- `k8s/.functions` - Kubernetes shortcuts
- `terraform/.functions` - Terraform shortcuts
- `telepresence/.functions` - Telepresence shortcuts
- `lightspeed/.functions` - Work-specific functions
- `general/.functions` - General utilities

## Adding New Packages

1. Create a new directory: `mkdir newpackage`
2. Add your config files to that directory
3. Add the package name to the `PACKAGES` array in `install.sh`
4. Run `./install.sh` or `stow -t ~ newpackage`

## Troubleshooting

### Stow conflicts with existing files

If you have existing files that conflict with Stow:

```bash
# Backup existing file
mv ~/.bashrc ~/.bashrc.backup

# Then install
./install.sh
```

### Check what Stow would do (dry run)

```bash
stow -n -t ~ shell    # Shows what would be linked without doing it
```

### Remove a specific package

```bash
stow -D -t ~ package-name
```

## Additional Setup

### Homebrew Packages

Install development tools:

```bash
./brew/install.sh
```

### Git Hooks

Git hooks are automatically installed when you stow the `git` package. The `prepare-commit-msg` hook automatically prepends JIRA ticket IDs from branch names to commit messages.

## Repository Structure

```
dotfiles/
├── shell/              # Shell configs (stowed)
├── git/               # Git configs (stowed)
├── k8s/               # Kubernetes configs (stowed)
├── terraform/         # Terraform configs (stowed)
├── telepresence/      # Telepresence configs (stowed)
├── lightspeed/        # Work-specific configs (stowed)
├── general/           # General utilities (stowed)
├── brew/              # Homebrew install script (not stowed)
├── install.sh         # Installation script
├── uninstall.sh       # Uninstallation script
└── README.md          # This file
```

## License

Personal configuration files - use at your own risk.
