#!/usr/bin/env bash

set -e

NC='\033[0m'
error() { echo -e "\033[0;31m[ERROR]${NC} $1"; } # RED
ok() { echo -e "\033[0;32m[OK]${NC} $1"; }       # GREEN
warn() { echo -e "\033[1;33m[WARN]${NC} $1"; }   # YELLOW
info() { echo -e "\033[0;34m[INFO]${NC} $1"; }   # BLUE

CACHE_FILE="$HOME/.cache/distro"

# Install terminal tools
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

    . "$CACHE_FILE"

    if [ "$distro" = "alpine" ]; then
        sudo apk add eudev

        # Start udev immediately
        sudo rc-service udev start

        # Enable udev to start on boot
        sudo rc-update add udev sysinit
    fi

    # Install kmonad based on installation type
    if [ "$install_type" = "multi-user" ]; then
        info "Installing kmonad to system-wide profile ($install_type)..."
        sudo env "PATH=$PATH" nix profile add --profile /nix/var/nix/profiles/default github:kmonad/kmonad?dir=nix
        local kmonad_bin="/nix/var/nix/profiles/default/bin/kmonad"
    else
        info "Installing kmonad to user profile ($install_type)..."
        nix profile add github:kmonad/kmonad?dir=nix
        local kmonad_bin="$HOME/.local/state/nix/profiles/profile/bin/kmonad"
        
        # Create symlink for system-wide access
        info "Creating system-wide symlink for kmonad binary..."
        sudo mkdir -p /usr/local/bin
        sudo ln -sf "$kmonad_bin" /usr/local/bin/kmonad
        kmonad_bin="/usr/local/bin/kmonad"
    fi

    info "Creating kmonad system user..."
    if ! id -u kmonad >/dev/null 2>&1; then
        local nologin_path="$(which nologin 2>/dev/null || echo '/sbin/nologin')"
    
        if [ "$distro" = "alpine" ]; then
            sudo addgroup -S kmonad 2>/dev/null || true
            sudo adduser -S -D -H -s "$nologin_path" -G kmonad kmonad
        else
            sudo useradd -r -s "$nologin_path" -d /var/empty kmonad
        fi
    fi

    if ! getent group input >/dev/null; then
        warn "input group does not exist, creating it..."
        if [ "$distro" = "alpine" ]; then
            sudo addgroup -S input
        else
            sudo groupadd -r input
        fi
    fi
    info "Adding kmonad user to input group..."
    if [ "$distro" = "alpine" ]; then
        sudo addgroup kmonad input
    else
        sudo usermod -aG input kmonad
    fi

    # Setup uinput module
    info "Setting up uinput kernel module..."
    sudo modprobe uinput

    # Detect init system
    local init_system="unknown"
    if command -v systemctl >/dev/null 2>&1 && systemctl --version >/dev/null 2>&1; then
        init_system="systemd"
    elif command -v rc-update >/dev/null 2>&1; then
        init_system="openrc"
    elif [ -f /etc/init.d/cron ] && [ ! -d /run/systemd/system ]; then
        init_system="sysvinit"
    fi

    info "Detected init system: $init_system"

    # Make uinput load at boot
    case "$init_system" in
        systemd)
            if [ ! -f /etc/modules-load.d/uinput.conf ]; then
                echo "uinput" | sudo tee /etc/modules-load.d/uinput.conf
            fi
            ;;
        openrc)
            if ! grep -q "^uinput$" /etc/modules 2>/dev/null; then
                echo "uinput" | sudo tee -a /etc/modules
            fi
            ;;
        *)
            # Generic approach for other init systems
            if [ -f /etc/modules ]; then
                if ! grep -q "^uinput$" /etc/modules; then
                    echo "uinput" | sudo tee -a /etc/modules
                fi
            elif [ -d /etc/modules-load.d ]; then
                echo "uinput" | sudo tee /etc/modules-load.d/uinput.conf
            fi
            ;;
    esac

    # Set uinput permissions via udev rule
    # New kmonad version uses CAP_DAC_OVERRIDE, but we still set permissions for compatibility
    info "Creating udev rule for uinput..."
    sudo tee /etc/udev/rules.d/90-uinput.rules > /dev/null << 'EOF'
KERNEL=="uinput", MODE="0660", GROUP="input", OPTIONS+="static_node=uinput"
EOF

    # Reload udev rules
    if command -v udevadm >/dev/null 2>&1; then
        sudo udevadm control --reload-rules
        sudo udevadm trigger
    fi

    # Copy config to system directory
    local kmonad_dir="/etc/kmonad"
    info "Copying kmonad config to $kmonad_dir..."
    sudo mkdir -p "$kmonad_dir"
    sudo cp "$kmonad_config" "$kmonad_dir/"

    # Install service based on init system
    case "$init_system" in
        systemd)
            install_kmonad_systemd "$kmonad_bin"
            ;;
        openrc)
            install_kmonad_openrc "$kmonad_bin"
            ;;
        *)
            warn "Unsupported init system: $init_system"
            warn "You'll need to manually set up kmonad to start at boot"
            info "Run kmonad manually with: sudo -u kmonad $kmonad_bin /etc/kmonad/colemaxx.kbd"
            return 0
            ;;
    esac
}

install_kmonad_systemd() {
    local kmonad_bin="$1"
    info "Creating systemd service..."
    sudo tee /etc/systemd/system/kmonad.service > /dev/null << EOF
[Unit]
Description=KMonad keyboard configuration daemon
Documentation=https://github.com/kmonad/kmonad
After=local-fs.target

[Service]
Type=simple
User=kmonad
Group=kmonad
SupplementaryGroups=input
ExecStart=$kmonad_bin /etc/kmonad/colemaxx.kbd
Restart=on-failure
RestartSec=3
StandardOutput=journal
StandardError=journal

# Security hardening
NoNewPrivileges=true
PrivateTmp=true
ProtectSystem=strict
ProtectHome=true
ProtectKernelTunables=true
ProtectKernelModules=true
ProtectControlGroups=true
ReadWritePaths=/dev/uinput
RestrictRealtime=true
RestrictSUIDSGID=true

# Required capabilities for new kmonad version
AmbientCapabilities=CAP_DAC_OVERRIDE
CapabilityBoundingSet=CAP_DAC_OVERRIDE

[Install]
WantedBy=multi-user.target
EOF

    info "Enabling and starting kmonad service..."
    sudo systemctl daemon-reload
    sudo systemctl enable --now kmonad.service

    sleep 2
    if sudo systemctl is-active --quiet kmonad.service; then
        ok "Kmonad installed and service started successfully"
        info "Check status with: sudo systemctl status kmonad.service"
    else
        error "Kmonad service failed to start"
        warn "Check logs with: sudo journalctl -u kmonad.service -n 50"
        return 1
    fi
}

install_kmonad_openrc() {
    local kmonad_bin="$1"
    info "Creating OpenRC init script..."
    sudo tee /etc/init.d/kmonad > /dev/null << EOF
#!/sbin/openrc-run
# KMonad keyboard configuration daemon

name="kmonad"
description="KMonad keyboard configuration daemon"
command="$kmonad_bin"
command_args="/etc/kmonad/colemaxx.kbd"
command_user="kmonad:kmonad"
command_background="yes"

pidfile="/run/\${RC_SVCNAME}.pid"
output_log="/var/log/kmonad/kmonad.log"
error_log="/var/log/kmonad/kmonad.err"

depend() {
    need localmount
    after bootmisc
    keyword -shutdown
}

start_pre() {
    # Ensure log directory exists
    checkpath --directory --owner kmonad:kmonad --mode 0755 /var/log/kmonad
    
    # Ensure uinput module is loaded
    if ! lsmod | grep -q uinput; then
        modprobe uinput || {
            eerror "Failed to load uinput module"
            return 1
        }
    fi
    
    # Check if kmonad user is in input group
    if ! groups kmonad | grep -q input; then
        ewarn "kmonad user is not in input group"
        ewarn "Run: sudo adduser kmonad input"
    fi
}
EOF

    sudo chmod +x /etc/init.d/kmonad

    info "Enabling and starting kmonad service..."
    sudo rc-update add kmonad default
    sudo rc-service kmonad start

    sleep 2
    if sudo rc-service kmonad status | grep -q "started"; then
        ok "Kmonad installed and service started successfully"
        info "Check status with: sudo rc-service kmonad status"
        info "View logs at: /var/log/kmonad/kmonad.log"
    else
        error "Kmonad service failed to start"
        warn "Check logs at: /var/log/kmonad/kmonad.err"
        warn "Run manually: sudo rc-service kmonad start"
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

setup_shell() {
    info "Setting up nushell as default shell..."
    local distro=$1
    local nu_path="$(which nu)"

    if [ "$distro" = "alpine" ]; then
        sudo apk add linux-pam
        sudo mkdir -p /etc/pam.d
        sudo tee /etc/pam.d/chsh > /dev/null << 'EOF'
auth       sufficient   pam_rootok.so
auth       required     pam_unix.so
account    required     pam_unix.so
session    required     pam_unix.so
EOF
    fi
    
    if [ -z "$nu_path" ]; then
        error "nushell (nu) not found in PATH"
        exit 1
    fi
    
    # Add to /etc/shells if not already present
    if ! grep -q "^$nu_path$" /etc/shells 2>/dev/null; then
        info "Adding $nu_path to /etc/shells"
        echo "$nu_path" | sudo tee -a /etc/shells > /dev/null
    else
        info "Shell already in /etc/shells"
    fi
    
    info "Changing default shell to nushell..."
    sudo chsh -s "$nu_path" "$USER"
}

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
            info "NixOS detected - Exiting..."
            exit 0
            ;;
        unknown)
            warn "Unknown distribution"
            ;;
        *)
            info "Supported distribution: $distro"
            ;;
    esac
    
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

    link_configs
    
    setup_shell "$distro"
    
    ok "Setup complete!"
    info "Please log out and log back in to use nushell as your default shell"
}

main "$@"
