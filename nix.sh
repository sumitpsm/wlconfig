#!/usr/bin/env bash

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

error() { echo -e "${RED}[ERROR]${NC} $1"; }
ok() { echo -e "${GREEN}[OK]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
info() { echo -e "${BLUE}[INFO]${NC} $1"; }

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
    elif [ -f /etc/slackware-release ] || [ -f /etc/slackware-version ]; then
        echo "slackware"
    elif [ -f /etc/ximper-release ] || [ -f /etc/ximper ]; then
        echo "ximper"
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

# Save distro info to cache file
save_distro_info() {
    local distro=$1
    local is_container=$2

    mkdir -p "$HOME/.cache"
    cat > "$CACHE_FILE" <<EOF
distro=$distro
container=$is_container
EOF

    ok "Saved distro info to $CACHE_FILE"
}

# Install Nix
install_nix() {
    local distro=$1
    local is_container=$2

    info "Installing Nix package manager..."

    local install_type="multi-user"

    if [ "$distro" = "alpine" ]; then
        install_type="single-user"
        info "Alpine detected: using single-user installation"
    elif [ "$is_container" = "yes" ]; then
        install_type="single-user"
        info "Container detected: using single-user installation"
    elif ! command -v systemctl >/dev/null 2>&1; then
        install_type="single-user"
        info "No systemd detected: using single-user installation"
    fi

    local warning="Failed to install some dependencies"

    info "Installing dependencies for $distro..."
    case "$distro" in
        alpine)
            doas apk add curl xz sudo bash || warn $warning
            doas adduser $USER wheel
            doas addgroup $USER wheel
            ;;
        arch|manjaro)
            if command -v pacman >/dev/null 2>&1; then
                sudo pacman -Sy --noconfirm curl xz || warn $warning
            fi
            ;;
        debian|ubuntu|linuxmint|pop)
            if command -v apt-get >/dev/null 2>&1; then
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
        solus)
            if command -v eopkg >/dev/null 2>&1; then
                sudo eopkg install -y curl xz || warn $warning
            fi
            ;;
        slackware)
            if command -v slackpkg >/dev/null 2>&1; then
                sudo slackpkg install curl xz || warn $warning
            elif command -v installpkg >/dev/null 2>&1; then
                sudo installpkg curl xz || warn $warning
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

main() {
    info "Nix Setup Script"
    info "================="

    local distro=$(detect_distro)
    info "Detected distribution: $distro"

    local is_container=$(detect_container)
    if [ "$is_container" = "yes" ]; then
        info "Running in container"
    fi

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

    if command -v nix >/dev/null 2>&1; then
        ok "Nix is already installed"
    else
        install_nix "$distro" "$is_container"
        ok "Installation complete!"
    fi

    save_distro_info "$distro" "$is_container"

    ok "Please reboot, then run ./setup.sh"
}

main "$@"
