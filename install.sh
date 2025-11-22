#!/bin/bash

# Dotfiles installation script using GNU Stow
# This script creates symlinks from the dotfiles directory to your home directory

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get the directory where this script is located
CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$CONFIG_DIR"

# Check if Stow is installed
if ! command -v stow &> /dev/null; then
    echo -e "${RED}Error: GNU Stow is not installed.${NC}"
    echo "Install it with:"
    echo "  macOS: brew install stow"
    echo "  Linux: sudo apt-get install stow  # or your package manager"
    exit 1
fi

echo -e "${GREEN}Installing dotfiles using GNU Stow...${NC}"
echo ""

# List of packages to stow
PACKAGES=(
    "shell"
    "git"
    "k8s"
    "terraform"
    "telepresence"
    "lightspeed"
    "general"
)

# Function to stow a package
stow_package() {
    local package=$1
    if [ -d "$package" ]; then
        echo -e "${YELLOW}Stowing $package...${NC}"
        stow -t "$HOME" "$package" 2>&1 | grep -v "BUG in find_stowed_path" || true
        echo -e "${GREEN}✓ $package installed${NC}"
    else
        echo -e "${YELLOW}⚠ $package directory not found, skipping${NC}"
    fi
}

# Stow each package
for package in "${PACKAGES[@]}"; do
    stow_package "$package"
done

echo ""
echo -e "${GREEN}✓ Dotfiles installation complete!${NC}"
echo ""
echo "To uninstall, run: ./uninstall.sh"
echo "Or manually: stow -D -t ~ <package-name>"
