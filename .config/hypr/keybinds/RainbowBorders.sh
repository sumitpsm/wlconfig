#!/usr/bin/env bash

function random_hex() {
    random_hex=("0xff$(openssl rand -hex 3)")
    echo $random_hex
}

RAINBOW_BORDERS_FILE="$HOME/.cache/hyprland/.rainbow_borders"
RAINBOW_BORDERS_STATE=$(cat $RAINBOW_BORDERS_FILE 2>/dev/null)

if [[ $RAINBOW_BORDERS_STATE == "disabled" ]]; then
    # rainbow colors only for active window
    hyprctl keyword general:col.active_border $(random_hex) $(random_hex) $(random_hex) $(random_hex) $(random_hex) $(random_hex) $(random_hex) $(random_hex) $(random_hex) $(random_hex)  270deg
    # rainbow colors for inactive window (uncomment to take effect)
    # hyprctl keyword general:col.inactive_border $(random_hex) $(random_hex) $(random_hex) $(random_hex) $(random_hex) $(random_hex) $(random_hex) $(random_hex) $(random_hex) $(random_hex) 270deg
    echo "enabled" > $RAINBOW_BORDERS_FILE
else
    DEFAULT_BORDER_COLOR="$(cat $HOME/.config/hypr/themes/.pallete.conf | grep color10 | awk -F'[()]' '{print $2}')"
    hyprctl keyword general:col.active_border "0xff$DEFAULT_BORDER_COLOR"
    echo "disabled" > $RAINBOW_BORDERS_FILE
fi
