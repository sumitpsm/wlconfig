#!/usr/bin/env bash

# Get current focused monitor
CURRENT_MONITOR=$(hyprctl monitors | awk '/^Monitor/{name=$2} /focused: yes/{print name}')

# Construct the full path to the cache file
CACHE_FILE="$HOME/.cache/swww/$CURRENT_MONITOR"

# Check if the cache file exists for the current monitor output
if [ -f "$CACHE_FILE" ]; then
  # Get the wallpaper path from the cache file
  WALLPAPER_PATH=$(grep -v 'Lanczos3' "$CACHE_FILE" | head -n 1)
  swww img "$WALLPAPER_PATH"
fi
