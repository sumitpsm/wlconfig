#!/usr/bin/env bash

# installing rust components
if [ $(nix-store -q --requisites /run/current-system ~/.nix-profile | grep rustup | cut -d - -f2) == rustup ]; then
  if [ $(rustup toolchain list | grep stable | cut -d - -f1) == stable ]; then
    rustup update
  else
    rustup toolchain install stable
    rustup component add rust-analyzer
  fi
fi
