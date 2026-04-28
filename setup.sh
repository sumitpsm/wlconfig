#!/usr/bin/env bash

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
error() { echo -e "${RED}[ERROR]${NC} $1"; }
ok() { echo -e "${GREEN}[OK]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
info() { echo -e "${BLUE}[INFO]${NC} $1"; }

# Nix configuration content
NIX_CONF_CONTENT='experimental-features = nix-command flakes
auto-optimise-store = true
use-xdg-base-directories = true
'

CACHE_FILE="$HOME/.cache/distro"

# Setup Nix configuration
setup_nix_config() {
    info "Setting up Nix configuration..."
    
    local nix_conf_dir="$HOME/.config/nix"
    local nix_conf_file="$nix_conf_dir/nix.conf"
    
    # Create directory
    mkdir -p "$nix_conf_dir"
    
    # Check if config already exists
    if [ -f "$nix_conf_file" ]; then
        warn "Nix config already exists at $nix_conf_file"
        warn "Backing up to $nix_conf_file.bak"
        cp "$nix_conf_file" "$nix_conf_file.bak"
    fi
    
    # Write configuration
    echo "$NIX_CONF_CONTENT" > "$nix_conf_file"
    
    ok "Nix configuration created at $nix_conf_file"
}

# Install dev tools using Nix
install_dev_tools() {
    info "Installing development tools..."
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    [ -f "$script_dir/flake.nix" ] || { error "flake.nix not found"; exit 1; }
    cd "$script_dir" && nix profile add .#dev-tools
    ok "Development tools installed"
}

# Link configurations using init.nu
link_configs() {
    info "Linking configurations..."
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    [ -f "$script_dir/init.nu" ] || { error "init.nu not found"; exit 1; }
    cd "$script_dir" && nix run nixpkgs#nushell -- init.nu
    ok "Configurations linked"
}

# Main function
main() {
    info "Wayland Setup Script"
    info "====================="
    
    # Load distro info from cache
    . "$HOME/.cache/distro"
    info "Detected distribution: $distro"
    
    # Handle different distributions
    case "$distro" in
        nixos)
            info "NixOS detected - Nix is already installed"
            exit 0
            ;;
        unknown)
            warn "Unknown distribution"
            ;;
        *)
            info "Supported distribution: $distro"
            ;;
    esac
    
    # Verify Nix is available
    if ! command -v nix >/dev/null 2>&1; then
        error "Nix command not found after installation"
        error "Please restart your terminal and run this script again"
        exit 1
    fi
    
    # Setup Nix configuration
    setup_nix_config
    
    # Install dev tools
    install_dev_tools
    
    # Link configs
    link_configs
    
    # Change shell to nushell (automatic, no prompt)
    case "$distro" in
        alpine)
            doas chsh -s "$(which nu)" "$USER"
            ;;
        *)
            sudo chsh -s "$(which nu)" "$USER"
            ;;
    esac
    ok "Default shell changed to nushell"
    
    ok "Setup complete!"
    info "Please restart your terminal or run: source ~/.nix-profile/etc/profile.d/nix.sh"
    info "Then log out and log back in to use nushell as your default shell"
}

# Run main function
main "$@"
