#!/usr/bin/env bash

# initializing repository path
if [ -d "$1" ]; then
  DIRPATH="$1"
else
  DIRPATH=$(pwd)
fi

# checking for flake.nix
if ! [ -f "$DIRPATH/flake.nix" ]; then
  echo "Error: flake.nix not found in $DIRPATH"
  exit 1
fi

# fetching current user home path
USRHOME=$(echo $DIRPATH | cut -d / -f1,2,3)

# linking configs for the current user
ln -s $DIRPATH/.config/ssh/config      $USRHOME/.ssh/config
ln -s $DIRPATH/.config/helix           $USRHOME/.config/helix
ln -s $DIRPATH/.config/yazi            $USRHOME/.config/yazi
ln -s $DIRPATH/.config/zellij          $USRHOME/.config/zellij
ln -s $DIRPATH/.config/kitty           $USRHOME/.config/kitty

# linking configs for the root user
ln -s $USRHOME/.config/helix           /root/.config/helix
ln -s $USRHOME/.config/yazi            /root/.config/yazi
ln -s $USRHOME/.config/zellij          /root/.config/zellij
ln -s $USRHOME/.config/kitty           /root/.config/kitty

