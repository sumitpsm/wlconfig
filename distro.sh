#!/bin/bash

# distro.sh - Setup script for Linux distributions
# Supports: arch, opensuse, fedora, debian, gentoo, freebsd, ubuntu, void, slackware, alpine, ximper, solus, nixos

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

# Detect distribution (also detects NixOS via ID=nixos)
detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo "$ID" | tr '[:upper:]' '[:lower:]'
    elif [ -f /etc/debian_version ]; then
        echo "debian"
    elif [ -f /etc/fedora-release ]; then
        echo "fedora"
    elif [ -f /etc/arch-release ]; then
        echo "arch"
    elif [ -f /etc/gentoo-release ]; then
        echo "gentoo"
    elif [ -f /etc/alpine-release ]; then
        echo "alpine"
    elif [ -f /etc/void-release ]; then
        echo "void"
    elif [ -f /etc/solus-release ]; then
        echo "solus"
    elif [ -f /etc/freebsd-version ]; then
        echo "freebsd"
    else
        echo "unknown"
    fi
}

# Detect if running in container
detect_container() {
    # Check for common container indicators
    if [ -f /.dockerenv ] || [ -f /run/.containerenv ]; then
        echo "yes"
        return
    fi
    
    # Check cgroup
    if [ -f /proc/1/cgroup ]; then
        if grep -qE 'docker|lxc|podman|containerd|kubepods' /proc/1/cgroup 2>/dev/null; then
            echo "yes"
            return
        fi
    fi
    
    # Check systemd-detect-virt if available
    if command -v systemd-detect-virt >/dev/null 2>&1; then
        if systemd-detect-virt --container 2>/dev/null | grep -qv "none"; then
            echo "yes"
            return
        fi
    fi
    
    echo "no"
}

# Change shell to nushell
change_shell_to_nushell() {
    info "Changing default shell to nushell..."
    
    local nu_path
    nu_path=$(which nu 2>/dev/null || echo "$HOME/.nix-profile/bin/nu")
    
    if [ ! -x "$nu_path" ]; then
        warn "nushell not found at $nu_path"
        return
    fi
    
    # Change shell using chsh with sudo
    if sudo chsh -s "$nu_path" "$USER"; then
        ok "Default shell changed to nushell ($nu_path)"
        info "You will need to log out and log back in for the change to take effect"
    else
        warn "Failed to change shell to nushell"
        info "You can manually change it later with: chsh -s $nu_path"
    fi
}

# Install Nix
install_nix() {
    local distro=$1
    local is_container=$2
    
    info "Installing Nix package manager..."
    
    # Determine installation type
    local install_type="multi-user"
    
    # Alpine always uses single-user (no systemd by default)
    if [ "$distro" = "alpine" ]; then
        install_type="single-user"
        info "Alpine detected: using single-user installation"
    # Containers use single-user
    elif [ "$is_container" = "yes" ]; then
        install_type="single-user"
        info "Container detected: using single-user installation"
    # Check for systemd
    elif ! command -v systemctl >/dev/null 2>&1; then
        install_type="single-user"
        info "No systemd detected: using single-user installation"
    fi
    
    # Install dependencies based on distro
    case "$distro" in
        alpine)
            info "Installing dependencies for Alpine..."
            if command -v apk >/dev/null 2>&1; then
                apk add --no-cache curl xz sudo || warn "Failed to install some dependencies"
            fi
            ;;
        arch|manjaro)
            info "Installing dependencies for Arch..."
            if command -v pacman >/dev/null 2>&1; then
                sudo pacman -Sy --noconfirm curl xz sudo || warn "Failed to install some dependencies"
            fi
            ;;
        debian|ubuntu|linuxmint|pop)
            info "Installing dependencies for Debian/Ubuntu..."
            if command -v apt-get >/dev/null 2>&1; then
                sudo apt-get update
                sudo apt-get install -y curl xz-utils sudo || warn "Failed to install some dependencies"
            fi
            ;;
        fedora|rhel|centos|rocky|almalinux)
            info "Installing dependencies for Fedora/RHEL..."
            if command -v dnf >/dev/null 2>&1; then
                sudo dnf install -y curl xz sudo || warn "Failed to install some dependencies"
            elif command -v yum >/dev/null 2>&1; then
                sudo yum install -y curl xz sudo || warn "Failed to install some dependencies"
            fi
            ;;
        opensuse*)
            info "Installing dependencies for openSUSE..."
            if command -v zypper >/dev/null 2>&1; then
                sudo zypper install -y curl xz sudo || warn "Failed to install some dependencies"
            fi
            ;;
        gentoo)
            info "Installing dependencies for Gentoo..."
            if command -v emerge >/dev/null 2>&1; then
                sudo emerge -v net-misc/curl app-arch/xz-utils || warn "Failed to install some dependencies"
            fi
            ;;
        void)
            info "Installing dependencies for Void..."
            if command -v xbps-install >/dev/null 2>&1; then
                sudo xbps-install -Sy curl xz sudo || warn "Failed to install some dependencies"
            fi
            ;;
        solus)
            info "Installing dependencies for Solus..."
            if command -v eopkg >/dev/null 2>&1; then
                sudo eopkg install -y curl xz sudo || warn "Failed to install some dependencies"
            fi
            ;;
        slackware)
            info "Installing dependencies for Slackware..."
            # Slackware typically has curl and xz in base
            info "Assuming curl and xz are available on Slackware"
            ;;
        freebsd)
            info "Installing dependencies for FreeBSD..."
            if command -v pkg >/dev/null 2>&1; then
                sudo pkg install -y curl xz sudo || warn "Failed to install some dependencies"
            fi
            ;;
        *)
            info "Installing dependencies for generic Linux..."
            ;;
    esac
    
    # Run Nix installer
    if [ "$install_type" = "single-user" ]; then
        info "Running single-user Nix installation..."
        curl -L https://nixos.org/nix/install | sh -s -- --no-daemon
    else
        info "Running multi-user Nix installation..."
        curl -L https://nixos.org/nix/install | sh -s -- --daemon
    fi
    
    # Source Nix environment
    if [ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
        . "$HOME/.nix-profile/etc/profile.d/nix.sh"
    elif [ -f /etc/profile.d/nix.sh ]; then
        . /etc/profile.d/nix.sh
    fi
    
    ok "Nix installed successfully"
}

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
    
    # Get script directory
    local script_dir
    script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    # Check if flake.nix exists
    if [ ! -f "$script_dir/flake.nix" ]; then
        error "flake.nix not found in $script_dir"
        exit 1
    fi
    
    # Install dev-tools package
    cd "$script_dir"
    nix profile install .#dev-tools
    
    ok "Development tools installed successfully"
}

# Link configurations using init.nu
link_configs() {
    info "Linking configurations..."
    
    local script_dir
    script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    # Check if init.nu exists
    if [ ! -f "$script_dir/init.nu" ]; then
        error "init.nu not found in $script_dir"
        exit 1
    fi
    
    # Run init.nu using nix run
    cd "$script_dir"
    nix run nixpkgs#nushell -- init.nu
    
    ok "Configurations linked successfully"
}

# Main function
main() {
    info "Linux Distribution Setup Script"
    info "================================"
    
    # Detect distribution
    local distro
    distro=$(detect_distro)
    info "Detected distribution: $distro"
    
    # Detect container
    local is_container
    is_container=$(detect_container)
    if [ "$is_container" = "yes" ]; then
        info "Running in container"
    fi
    
    # Handle different distributions
    case "$distro" in
        nixos)
            info "NixOS detected - Nix is already installed and configured"
            link_configs
            exit 0
            ;;
        arch|debian|fedora|gentoo|ubuntu|void|slackware|alpine|solus|opensuse*|freebsd|ximper)
            info "Supported distribution: $distro"
            ;;
        *)
            warn "Untested distribution: $distro - attempting generic setup"
            ;;
    esac
    
    # Check and install Nix (only for non-NixOS)
    if ! command -v nix >/dev/null 2>&1; then
        install_nix "$distro" "$is_container"
        # Try to source Nix environment after installation
        if [ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
            . "$HOME/.nix-profile/etc/profile.d/nix.sh"
        elif [ -f /etc/profile.d/nix.sh ]; then
            . /etc/profile.d/nix.sh"
        fi
    else
        ok "Nix is already installed"
    fi
    
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
    change_shell_to_nushell
    
    echo ""
    ok "Setup complete!"
    info "Please restart your terminal or run: source ~/.nix-profile/etc/profile.d/nix.sh"
    info "Then log out and log back in to use nushell as your default shell"
}

# Run main function
main "$@"
