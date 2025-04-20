#!/usr/bin/env bash

# initializing repository path
DIRROOT=$(pwd)

# checking for flake.nix
if ! [ -f "$DIRROOT/flake.nix" ]; then
  echo "Error: flake.nix not found in $DIRROOT"
  exit 1
fi

# fetching current user home path
USRHOME=$(echo $DIRROOT | cut -d / -f1,2,3)

# function for linking configs for the current user
function check_symlink() {
  TARGET_ENTRY_PATH="$DIRROOT/$1";
  SYMLINK_ENTRY="$USRHOME/$2";

  if ! [ $(readlink $SYMLINK_ENTRY) == $TARGET_ENTRY_PATH ]; then
    mv $SYMLINK_ENTRY          "${SYMLINK_ENTRY}.bak"
    ln -s $TARGET_ENTRY_PATH   $SYMLINK_ENTRY
    echo "[+] SymLink created: $SYMLINK_ENTRY"
  else
    echo "[-] SymLink already present: $SYMLINK_ENTRY"
  fi
}

# linking configs for the current user
check_symlink ".config/ssh/config" ".ssh/config"
check_symlink ".config/helix"      ".config/helix"
check_symlink ".config/yazi"       ".config/yazi"
check_symlink ".config/zellij"     ".config/zellij"
check_symlink ".config/kitty"      ".config/kitty"
check_symlink "scripts"            ".local/scripts"

# function for linking configs for the current user
function check_symlink() {
  TARGET_ENTRY_PATH="$DIRROOT/$1";
  SYMLINK_ENTRY="/root/$2";

  if ! [ $(readlink $SYMLINK_ENTRY) == $TARGET_ENTRY_PATH ]; then
    mv $SYMLINK_ENTRY          "${SYMLINK_ENTRY}.bak"
    ln -s $TARGET_ENTRY_PATH   $SYMLINK_ENTRY
    echo "[+] SymLink created: $SYMLINK_ENTRY"
  else
    echo "[-] SymLink already present: $SYMLINK_ENTRY"
  fi
}

# linking configs for the root user
check_root_symlink ".config/helix"   "/root/.config/helix"
check_root_symlink ".config/yazi"    "/root/.config/yazi"
check_root_symlink ".config/zellij"  "/root/.config/zellij"
