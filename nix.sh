#!/usr/bin/env bash

set -e

NC='\033[0m'
error() { echo -e "\033[0;31m[ERROR]${NC} $1"; } # RED
ok() { echo -e "\033[0;32m[OK]${NC} $1"; }       # GREEN
warn() { echo -e "\033[1;33m[WARN]${NC} $1"; }   # YELLOW
info() { echo -e "\033[0;34m[INFO]${NC} $1"; }   # BLUE

CACHE_FILE="$HOME/.cache/distro"

# Detect distribution
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
    elif [ -f /etc/alpine-release ]; then
        echo "alpine"
    elif [ -f /etc/opensuse-release ]; then
        echo "opensuse"
    elif [ -f /etc/gentoo-release ]; then
        echo "gentoo"
    elif [ -f /etc/void-release ]; then
        echo "void"
    elif [ -f /etc/slackware-release ] || [ -f /etc/slackware-version ]; then
        echo "slackware"
    elif [ -f /etc/solus-release ]; then
        echo "solus"
    elif [ -f /etc/ximper-release ] || [ -f /etc/ximper ]; then
        echo "ximper"
    elif [ -f /etc/freebsd-version ]; then
        echo "freebsd"
    else
        echo "unknown"
    fi
}

# Detect if running in container
detect_container() {
    if [ -f /.dockerenv ] || [ -f /run/.containerenv ]; then
        echo "yes"
        return
    fi

    if [ -f /proc/1/cgroup ]; then
        if grep -qE 'docker|lxc|podman|containerd|kubepods' /proc/1/cgroup 2>/dev/null; then
            echo "yes"
            return
        fi
    fi

    if command -v systemd-detect-virt >/dev/null 2>&1; then
        if systemd-detect-virt --container 2>/dev/null | grep -qv "none"; then
            echo "yes"
            return
        fi
    fi

    echo "no"
}

# Detect installation type based on environment
detect_install_type() {
    local is_container=$1
    
    if [ "$is_container" = "yes" ]; then
        echo "single-user"
    elif ! command -v systemctl >/dev/null 2>&1; then
        echo "single-user"
    else
        echo "multi-user"
    fi
}

# Install Nix
install_nix() {
    local distro=$1
    local is_container=$2
    local install_type=$3

    local warning="Failed to install some dependencies"

    info "Installing dependencies for $distro..."
    case "$distro" in
        debian|ubuntu|linuxmint|pop)
            if command -v apt >/dev/null 2>&1; then
                sudo sed -i '/^deb cdrom:/s/^/# /' /etc/apt/sources.list
                sudo apt update
                sudo apt install -y curl xz-utils || warn $warning
            fi
            ;;
        fedora|rhel|centos|rocky|almalinux)
            if command -v dnf >/dev/null 2>&1; then
                sudo dnf install -y curl xz || warn $warning
            elif command -v yum >/dev/null 2>&1; then
                sudo yum install -y curl xz || warn $warning
            fi
            ;;
        arch|manjaro)
            if command -v pacman >/dev/null 2>&1; then
                sudo pacman -Sy --noconfirm curl xz || warn $warning
            fi
            ;;
        alpine)
            doas apk add curl xz bash coreutils || warn $warning
            doas adduser $USER wheel
            doas addgroup $USER wheel
            grep -qxF 'export PATH="$HOME/.local/state/nix/profiles/profile/bin:$PATH"' /etc/profile || \
                echo 'export PATH="$HOME/.local/state/nix/profiles/profile/bin:$PATH"' | sudo tee -a /etc/profile
            ;;
        opensuse*)
            if command -v zypper >/dev/null 2>&1; then
                sudo zypper install -y curl xz || warn $warning
            fi
            ;;
        gentoo)
            if command -v emerge >/dev/null 2>&1; then
                sudo emerge -v net-misc/curl app-arch/xz-utils || warn $warning
            fi
            ;;
        void)
            if command -v xbps-install >/dev/null 2>&1; then
                sudo xbps-install -Sy curl xz || warn $warning
            fi
            ;;
        slackware)
            if command -v slackpkg >/dev/null 2>&1; then
                sudo slackpkg install curl xz || warn $warning
            elif command -v installpkg >/dev/null 2>&1; then
                sudo installpkg curl xz || warn $warning
            fi
            ;;
        solus)
            if command -v eopkg >/dev/null 2>&1; then
                sudo eopkg install -y curl xz || warn $warning
            fi
            ;;
        ximper)
            if command -v epmi >/dev/null 2>&1; then
                sudo epmi install curl xz || warn $warning
            fi
            ;;
        freebsd)
            if command -v pkg >/dev/null 2>&1; then
                sudo pkg install -y curl xz || warn $warning
            fi
            ;;
        *)
            ;;
    esac

    info "Running $install_type Nix installation..."
    if [ "$install_type" = "single-user" ]; then
        curl -L https://nixos.org/nix/install | sh -s -- --no-daemon
    else
        curl -L https://nixos.org/nix/install | sh -s -- --daemon
    fi
}

# Setup Nix configuration (system-wide for daemon, user-level for single-user)
setup_nix_config() {
    local install_type=$1
    
    info "Setting up Nix configuration for $install_type installation..."
    
    sudo mkdir -p /etc/nix

    local nix_conf_file="/etc/nix/nix.conf"
    local nix_conf_content
    if [ "$install_type" = "multi-user" ]; then
        nix_conf_content="build-users-group = nixbld
experimental-features = nix-command flakes
auto-optimise-store = true
trusted-users = root $USER
"
    else # Single-user installation
        nix_conf_content="experimental-features = nix-command flakes
auto-optimise-store = true
trusted-users = root $USER
"
    fi       

    # Check if config already exists
    if [ -f "$nix_conf_file" ]; then
        warn "Nix daemon config already exists at $nix_conf_file"
        warn "Backing up to $nix_conf_file.bak"
        sudo mv "$nix_conf_file" "$nix_conf_file.bak"
    fi
    echo "$nix_conf_content" | sudo tee "$nix_conf_file" > /dev/null
        
    if [ "$install_type" = "multi-user" ]; then
        info "Restarting Nix daemon..."
        sudo systemctl restart nix-daemon
        ok "Nix daemon configuration updated"
    fi
}

# Save distro info to cache file
save_distro_info() {
    local distro=$1
    local is_container=$2
    local install_type=$3

    mkdir -p "$HOME/.cache"
    cat > "$CACHE_FILE" <<EOF
distro=$distro
container=$is_container
install_type=$install_type
EOF

    ok "Saved distro info to $CACHE_FILE"
}

main() {
    info "Nix Setup Script"
    info "================="

    local distro=$(detect_distro)
    info "Detected distribution: $distro"

    local is_container=$(detect_container)
    if [ "$is_container" = "yes" ]; then
        info "Running in container"
    fi

    local install_type=$(detect_install_type "$is_container")

    case "$distro" in
        nixos)
            info "NixOS detected - Nix is already installed"
            exit 0
            ;;
        unknown)
            warn "Unsupported distribution"
            ;;
        *)
            info "Supported distribution: $distro"
            ;;
    esac

    if command -v nix >/dev/null 2>&1; then
        ok "Nix is already installed"
    else
        install_nix "$distro" "$is_container" "$install_type"
        ok "Installation complete!"
    fi

    setup_nix_config "$install_type"

    save_distro_info "$distro" "$is_container" "$install_type"

    ok "Please restart the shell session, then run ./setup.sh"
}

# Check if we have sudo access
if command -v doas >/dev/null 2>&1; then
    doas ln -s $(which doas) /usr/bin/sudo 2>/dev/null || warn "sudo is already linked"
elif ! sudo -v; then
    error "sudo access required for execution"
    exit 1
fi

main "$@"
