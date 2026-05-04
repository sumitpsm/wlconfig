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

CACHE_FILE="$HOME/.cache/distro"

# Install dev tools using Nix
install_dev_tools() {
    info "Installing development tools..."
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    [ -f "$script_dir/flake.nix" ] || { error "flake.nix not found"; exit 1; }
    cd "$script_dir" && nix profile add .#terminal
    ok "Development tools installed"
}

# Install kmonad keyboard mapper
install_kmonad() {
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local kmonad_config="$script_dir/hosts/nixstation/colemaxx.kbd"

    if [ ! -f "$kmonad_config" ]; then
        error "Kmonad config not found: $kmonad_config"
        exit 1
    fi

    info "Installing kmonad to system-wide profile..."
    sudo env "PATH=$PATH" nix profile add --profile /nix/var/nix/profiles/default github:kmonad/kmonad?dir=nix
    # nix profile add github:kmonad/kmonad?dir=nix

    info "Creating kmonad system user..."
    if ! id -u kmonad >/dev/null 2>&1; then
        sudo useradd -r -s /usr/sbin/nologin -d /var/empty kmonad
    fi

    # Add kmonad user to input and uinput groups
    info "Adding kmonad user to input groups..."
    sudo usermod -aG input kmonad 2>/dev/null || warn "input group may not exist"
    sudo usermod -aG uinput kmonad 2>/dev/null || warn "uinput group may not exist"

    # Setup uinput module
    info "Setting up uinput kernel module..."
    sudo modprobe uinput
    
    # Make uinput load at boot
    if [ ! -f /etc/modules-load.d/uinput.conf ]; then
        echo "uinput" | sudo tee /etc/modules-load.d/uinput.conf
    fi

    # Set uinput permissions via udev rule
    info "Creating udev rule for uinput..."
    sudo tee /etc/udev/rules.d/90-uinput.rules > /dev/null << 'EOF'
KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
EOF
    
    # Create uinput group if it doesn't exist
    if ! getent group uinput >/dev/null; then
        sudo groupadd -r uinput
        sudo usermod -aG uinput kmonad
    fi

    # Reload udev rules
    sudo udevadm control --reload-rules
    sudo udevadm trigger

    # Copy config to system directory
    local kmonad_dir="/etc/kmonad"
    info "Copying kmonad config to $kmonad_dir..."
    sudo mkdir -p "$kmonad_dir"
    sudo cp "$kmonad_config" "$kmonad_dir/"

    # Create system-wide systemd service
    info "Creating system-wide systemd service..."
    sudo tee /etc/systemd/system/kmonad.service > /dev/null << 'EOF'
[Unit]
Description=Kmonad keyboard mapper
After=multi-user.target
Wants=multi-user.target

[Service]
Type=simple
User=kmonad
Group=kmonad
SupplementaryGroups=input uinput
ExecStart=/nix/var/nix/profiles/default/bin/kmonad /etc/kmonad/colemaxx.kbd
Restart=on-failure
RestartSec=3
StandardOutput=journal
StandardError=journal

# Security hardening
NoNewPrivileges=true
PrivateTmp=true
ProtectSystem=strict
ProtectHome=true
ReadWritePaths=/dev/uinput

[Install]
WantedBy=multi-user.target
EOF

    # Enable and start service
    info "Enabling and starting kmonad service..."
    sudo systemctl daemon-reload
    sudo systemctl enable --now kmonad.service

    # Check service status
    sleep 2
    if sudo systemctl is-active --quiet kmonad.service; then
        ok "Kmonad installed and service started successfully"
    else
        error "Kmonad service failed to start"
        warn "Check logs with: sudo journalctl -u kmonad.service -n 50"
        return 1
    fi
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
    
    # Verify Nix is available
    if ! command -v nix >/dev/null 2>&1; then
        error "Nix command not found"
        error "Please restart your terminal and run this script again"
        exit 1
    fi

    # Load distro info from cache
    . "$CACHE_FILE"
    
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
    
    # Install dev tools
    install_dev_tools

    # Prompt for kmonad installation
    echo -n "Do you want to install kmonad keyboard mapper? (y/N): "
    read -r response
    case "$response" in
        y|Y)
            install_kmonad
            ;;
        *)
            info "Skipping kmonad installation"
            ;;
    esac

    # Link configs
    link_configs
    
    # Setup nushell
    setup_shell
    
    ok "Setup complete!"
    info "Please log out and log back in to use nushell as your default shell"
}

# Run main function
main "$@"
