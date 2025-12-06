#!/usr/bin/env nu

# Script for toggling Rainbow Borders on fly
def main [] {
    let state_dir = $"($env.HOME)/.local/state/hyprland"
    mkdir $state_dir

    let rainbow_borders_file = $"($state_dir)/.rainbow_borders"
    let rainbow_borders_state = (
      if ($rainbow_borders_file | path exists) {
        open $rainbow_borders_file | str trim
      } else {
        ""
      }
    )

    if $rainbow_borders_state == "disabled" {
      "enabled" | save -f $rainbow_borders_file
  
      # rainbow colors only for active window (use inactive_border for inactive windows)
      let colors = (1..10 | each { random_hex } | str join " ")
      hyprctl keyword general:col.active_border ...([$colors "270deg"] | flatten)
    } else {
      let palette_file = $"($env.HOME)/.config/hypr/themes/.palette.conf"
      let default_border_color = (
        open $palette_file 
        | lines 
        | find "color8" 
        | first 
        | parse "{_}({color})" 
        | get color.0
      )
  
      hyprctl keyword general:col.active_border $"0xff($default_border_color)"
      "disabled" | save -f $rainbow_borders_file
    }
} 

def random_hex [] {
  let hex = (openssl rand -hex 3 | str trim)
  $"0xff($hex)"
}
