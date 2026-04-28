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

# Nix configuration content (system-level, not user-level)
NIX_DAEMON_CONF_CONTENT="experimental-features = nix-command flakes
auto-optimise-store = true
trusted-users = root $USER
"

CACHE_FILE="$HOME/.cache/distro"

# Setup Nix configuration (system-wide for daemon)
setup_nix_config() {
    info "Setting up Nix daemon configuration..."
    
    local nix_conf_file="/etc/nix/nix.conf"
    
    # Check if we have sudo access
    if ! sudo -v; then
        error "sudo access required for Nix daemon configuration"
        exit 1
    fi
    
    # Create directory
    sudo mkdir -p /etc/nix
    
    # Check if config already exists
    if [ -f "$nix_conf_file" ]; then
        warn "Nix daemon config already exists at $nix_conf_file"
        warn "Backing up to $nix_conf_file.bak"
        cp "$nix_conf_file" "$nix_conf_file.bak"
    else
        echo "$NIX_DAEMON_CONF_CONTENT" | sudo tee "$nix_conf_file"
    fi
    
    # Restart Nix daemon
    info "Restarting Nix daemon..."
    sudo systemctl restart nix-daemon
    
    ok "Nix daemon configuration updated"
}

# Install dev tools using Nix
install_dev_tools() {
    info "Installing development tools..."
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    [ -f "$script_dir/flake.nix" ] || { error "flake.nix not found"; exit 1; }
    cd "$script_dir" && nix profile add .#terminal
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

# Add shell to /etc/shells and change default shell
setup_shell() {
    info "Setting up nushell as default shell..."
    
    local nu_path="$(which nu)"
    
    if [ -z "$nu_path" ]; then
        error "nushell (nu) not found in PATH"
        exit 1
    fi
    
    # Add to /etc/shells if not already present
    if ! grep -q "^$nu_path$" /etc/shells 2>/dev/null; then
        info "Adding $nu_path to /etc/shells"
        echo "$nu_path" | sudo tee -a /etc/shells
    else
        info "Shell already in /etc/shells"
    fi
    
    # Change shell
    info "Changing default shell to nushell..."
    case "$distro" in
        alpine)
            doas chsh -s "$nu_path" "$USER"
            ;;
        *)
            sudo chsh -s "$nu_path" "$USER"
            ;;
    esac
    
    ok "Default shell changed to nushell"
}

# Main function
main() {
    info "Wayland Setup Script"
    info "====================="
    
    # Load distro info from cache
    . "$CACHE_FILE"
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
        error "Nix command not found"
        error "Please restart your terminal and run this script again"
        exit 1
    fi
    
    # Setup Nix daemon configuration (must be before using Nix)
    setup_nix_config
    
    # Install dev tools
    install_dev_tools
    
    # Link configs
    link_configs
    
    # Setup nushell
    setup_shell
    
    ok "Setup complete!"
    info "Please log out and log back in to use nushell as your default shell"
}

# Run main function
main "$@"
