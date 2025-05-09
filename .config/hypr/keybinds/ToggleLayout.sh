#!/usr/bin/env bash

# Script for changing Hyprland Layouts (Master or Dwindle) on the fly

notif="$HOME/.config/hypr/scripts/layout.png"

LAYOUT=$(hyprctl -j getoption general:layout | jq '.str' | sed 's/"//g')

case $LAYOUT in
"master")
	hyprctl keyword general:layout dwindle
  notify-send -e -u low -i "$notif" " Dwindle Layout"
	;;
"dwindle")
	hyprctl keyword general:layout master
  notify-send -e -u low -i "$notif" " Master Layout"
	;;
*) ;;

esac
