#!/usr/bin/env nu

# Script for changing Hyprland Layouts (Master or Dwindle) on fly
def main [] {
	let notif = $"($env.HOME)/.config/hypr/scripts/layout.png"

	let layout = (hyprctl -j getoption general:layout | from json | get str)

	match $layout {
	  "master" => {
	    hyprctl keyword general:layout dwindle
	    notify-send -e -u low -i $notif " Dwindle Layout"
	  }
	  "dwindle" => {
	    hyprctl keyword general:layout master
	    notify-send -e -u low -i $notif " Master Layout"
	  }
	  _ => {}
	}
}
