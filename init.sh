#!/usr/bin/env bash

# The purpose of this script is to link all the configs
# provided in this repository to its original place in
# the system. The functionality of this script is not
# bounded to nixos, it can run on any linux system.

ERROR="$(tput setaf 1)[ERROR]$(tput sgr0)"
OK="$(tput setaf 2)[OK]$(tput sgr0)"
WARN="$(tput setaf 3)[WARN]$(tput sgr0)"
INFO="$(tput setaf 4)[INFO]$(tput sgr0)"

# initializing repository path
DIRROOT=$(pwd)

# checking for flake.nix
if ! [[ -f "$DIRROOT/flake.nix" ]]; then
  echo "$ERROR flake.nix not found in $DIRROOT"
  exit 1
fi

# fetching current user home path
USRHOME=$(echo $DIRROOT | cut -d / -f1,2,3)

# function for linking configs for the current user
function check_symlink() {
  TARGET_ENTRY_PATH="$DIRROOT/$1";
  SYMLINK_ENTRY="$USRHOME/$2";

  if [[ ! $(readlink $SYMLINK_ENTRY) == $TARGET_ENTRY_PATH ]]; then
    # (-e) for checking if the entry exists
    # (-h) for checking if the entry is a symlink
    # create backup if the entry exists and it's not a symlink
    if [[ -e $SYMLINK_ENTRY && ! -h $SYMLINK_ENTRY ]]; then
      echo -n "$WARN Backup created: "
      mv -v $SYMLINK_ENTRY        "${SYMLINK_ENTRY}.bak" 2>/dev/null
    fi
    echo -n "$OK SymLink created: "
    ln -sv $TARGET_ENTRY_PATH   $SYMLINK_ENTRY 2>/dev/null
  else
    echo "$INFO SymLink already present: $SYMLINK_ENTRY"
  fi
}

mkdir -p $HOME/.config/ $HOME/.local/ $HOME/.ssh/
mkdir -p $HOME/.local/share/nushell/

# linking configs for the current user
check_symlink "config/ssh_config"      ".ssh/config"
check_symlink "config/.gitconfig"      ".gitconfig"

check_symlink "config/nushell"         ".config/nushell"
check_symlink "config/helix"           ".config/helix"
check_symlink "config/zellij"          ".config/zellij"
check_symlink "config/yazi"            ".config/yazi"
check_symlink "config/btop"            ".config/btop"
check_symlink "config/hypr"            ".config/hypr"
check_symlink "config/alacritty"       ".config/alacritty"
check_symlink "config/kitty"           ".config/kitty"
check_symlink "config/gtk-3.0"         ".config/gtk-3.0"

# function for linking configs for the root user
function check_root_symlink() {
  TARGET_ENTRY_PATH="$USRHOME/$1";
  SYMLINK_ENTRY="/root/$2";

  if [[ ! $(sudo readlink $SYMLINK_ENTRY) == $TARGET_ENTRY_PATH ]]; then
    # (-e) for checking if the entry exists
    # (-h) for checking if the entry is a symlink
    # create backup if the entry exists and it's not a symlink
    if [[ -e $SYMLINK_ENTRY && ! -h $SYMLINK_ENTRY ]]; then
      echo -n "$WARN Backup created: "
      mv -v $SYMLINK_ENTRY        "${SYMLINK_ENTRY}.bak" 2>/dev/null
    fi
    echo -n "$OK SymLink created: "
    sudo ln -sv $TARGET_ENTRY_PATH   $SYMLINK_ENTRY 2>/dev/null
  else
    echo "$INFO SymLink already present: $SYMLINK_ENTRY"
  fi
}

sudo mkdir -p /root/.config
sudo mkdir -p /root/.local/share/nushell/

# linking configs for the root user
check_root_symlink ".config/nushell"       ".config/nushell"
check_root_symlink ".config/helix"         ".config/helix"
check_root_symlink ".config/zellij"        ".config/zellij"
check_root_symlink ".config/yazi"          ".config/yazi"
check_root_symlink ".config/btop"          ".config/btop"

# download wallpapers
read -n1 -rep "Would you like to download wallpapers [y/n]? " INPUT
if [[ $INPUT == "y" || $INPUT == "Y" ]]; then
  mkdir -p ~/media/wallpapers
  git clone --depth=1 https://github.com/sumit-modak/wallpapers.git ~/media/wallpapers
fi

# installing latest rust components
# if [[ $(nix-store -q --requisites /run/current-system ~/.nix-profile | grep rustup | cut -d - -f2) = "rustup" ]]; then
#   if [[ $(rustup toolchain list | grep stable | cut -d - -f1) = "stable" ]]; then
#     rustup update
#   else
#     rustup toolchain install stable
#     rustup default stable
#     rustup component add rust-analyzer
#   fi
# fi
