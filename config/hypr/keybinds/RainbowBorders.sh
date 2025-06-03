#!/usr/bin/env bash

# Script for toggling Rainbow Borders on fly

function random_hex() {
    random_hex=("0xff$(openssl rand -hex 3)")
    echo $random_hex
}

mkdir -p "$HOME/.local/state/hyprland"
RAINBOW_BORDERS_FILE="$HOME/.local/state/hyprland/.rainbow_borders"
RAINBOW_BORDERS_STATE=$(cat $RAINBOW_BORDERS_FILE 2>/dev/null)

if [[ $RAINBOW_BORDERS_STATE == "disabled" ]]; then
    echo "enabled" > $RAINBOW_BORDERS_FILE
    # rainbow colors only for active window (use inactive_border for inactive windows)
    # while true; do
        hyprctl keyword general:col.active_border $(random_hex) $(random_hex) $(random_hex) $(random_hex) $(random_hex) $(random_hex) $(random_hex) $(random_hex) $(random_hex) $(random_hex) 270deg
    # done 1>/dev/null
else
    DEFAULT_BORDER_COLOR="$(cat $HOME/.config/hypr/themes/.palette.conf | grep color8 | awk -F'[()]' '{print $2}')"
    hyprctl keyword general:col.active_border "0xff$DEFAULT_BORDER_COLOR"
    echo "disabled" > $RAINBOW_BORDERS_FILE
fi
