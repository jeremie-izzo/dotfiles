#!/bin/bash

# Dotfiles uninstallation script using GNU Stow
# This script removes symlinks created by install.sh

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
    exit 1
fi

echo -e "${YELLOW}Uninstalling dotfiles...${NC}"
echo ""

# List of packages to unstow
PACKAGES=(
    "shell"
    "git"
    "k8s"
    "terraform"
    "telepresence"
    "lightspeed"
    "general"
)

# Function to unstow a package
unstow_package() {
    local package=$1
    if [ -d "$package" ]; then
        echo -e "${YELLOW}Unstowing $package...${NC}"
        stow -D -t "$HOME" "$package" 2>&1 | grep -v "BUG in find_stowed_path" || true
        echo -e "${GREEN}✓ $package removed${NC}"
    fi
}

# Unstow each package
for package in "${PACKAGES[@]}"; do
    unstow_package "$package"
done

echo ""
echo -e "${GREEN}✓ Dotfiles uninstallation complete!${NC}"
