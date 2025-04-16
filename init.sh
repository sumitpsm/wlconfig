#!/usr/bin/env bash

DIRPATH="${HOME}/dev/main/sysconf"

# linking configs for the current user
ln -s $DIRPATH/.config/ssh/config $HOME/.ssh/config
ln -s $DIRPATH/.config/helix      $HOME/.config/helix
ln -s $DIRPATH/.config/yazi       $HOME/.config/yazi
ln -s $DIRPATH/.config/zellij     $HOME/.config/zellij
ln -s $DIRPATH/.config/kitty      $HOME/.config/kitty

# linking configs for the root user
ln -s $HOME/.config/helix         /root/.config/helix
ln -s $HOME/.config/yazi          /root/.config/yazi
ln -s $HOME/.config/zellij        /root/.config/zellij
ln -s $HOME/.config/kitty         /root/.config/kitty

