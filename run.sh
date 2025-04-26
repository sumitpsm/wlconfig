#!/usr/bin/env bash

# initializing repository path
IS_INIT="$1"
DIRROOT=$(pwd)

if [[ $IS_INIT = "-i" ]]; then
  if [ -f "$DIRROOT/init.sh" ]; then
    sudo ./init.sh
  else
    echo "./init.sh not found"
    exit 1
  fi
fi

# checking for flake.nix
if [[ -f "$DIRROOT/flake.nix" ]]; then
  # checking for hardware configuration
  if ! [[ -f "./nixos/hardware-configuration.nix" ]]; then
    sudo nixos-generate-config --show-hardware-config > ./nixos/hardware-configuration.nix
  fi
  # rebuilding nixos configuration
  git add . 2>/dev/null
  sudo nixos-rebuild switch --flake .
  git add . 2>/dev/null
else
  echo "Error: flake.nix not found in $DIRROOT"
  exit 1
fi

# installing lastest rust components
if [[ $(nix-store -q --requisites /run/current-system ~/.nix-profile | grep rustup | cut -d - -f2) = "rustup" ]]; then
  if [[ $(rustup toolchain list | grep stable | cut -d - -f1) = "stable" ]]; then
    rustup update
  else
    rustup toolchain install stable
    rustup component add rust-analyzer
  fi
fi

