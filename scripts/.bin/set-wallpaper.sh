#!/usr/bin/env bash

wallpaper_directory="$HOME/Pictures/wallpapers/"
split_directory="$HOME/Pictures/wallpapers/splits/"

# Select wallpaper (random or specified)
if [ -z "$1" ]; then
  selected_file=$(find "$wallpaper_directory" -maxdepth 1 -type f | shuf -n 1)
else
  selected_file=$1
fi

echo "$selected_file" > ~/.current-wallpaper

# Extract filename components
filename=$(basename "$selected_file")
name="${filename%.*}"
ext="${filename##*.}"

# Check if splits exist for this wallpaper
left_split="$split_directory/${name}-left.${ext}"
right_split="$split_directory/${name}-right.${ext}"

# Detect if running Wayland or X11
if [ -n "$WAYLAND_DISPLAY" ]; then
  # Wayland - use hyprpaper
  echo "Detected Wayland, using hyprpaper"
  
  # Check if hyprpaper is running, if not start it
  if ! pgrep -x hyprpaper > /dev/null; then
    hyprpaper &
    sleep 1
  fi
  
  # Get monitor names
  monitors=($(hyprctl monitors -j | jq -r '.[].name'))
  
  # Unload all previous wallpapers
  hyprctl hyprpaper unload all
  
  # Use splits if they exist, otherwise use original on both monitors
  if [ -f "$left_split" ] && [ -f "$right_split" ]; then
    echo "Using pre-split images"
    
    # Preload split images
    hyprctl hyprpaper preload "$left_split"
    hyprctl hyprpaper preload "$right_split"
    
    # Set wallpapers on each monitor
    if [ ${#monitors[@]} -ge 2 ]; then
      hyprctl hyprpaper wallpaper "${monitors[0]},$left_split"
      hyprctl hyprpaper wallpaper "${monitors[1]},$right_split"
    else
      hyprctl hyprpaper wallpaper "${monitors[0]},$left_split"
    fi
  else
    echo "Using original image on all monitors"
    
    # Standard image - use on all monitors
    hyprctl hyprpaper preload "$selected_file"
    
    for monitor in "${monitors[@]}"; do
      hyprctl hyprpaper wallpaper "$monitor,$selected_file"
    done
  fi
else
  # X11 - use feh
  echo "Detected X11, using feh"
  
  if [ -f "$left_split" ] && [ -f "$right_split" ]; then
    echo "Using pre-split images"
    # For feh with splits, we'd need xinerama/xrandr logic to position them
    # For now, just use the original image
    feh --bg-scale --no-xinerama "$selected_file"
  else
    echo "Using original image"
    feh --bg-scale --no-xinerama "$selected_file"
  fi
fi

# Send notification
if [ -z "$1" ]; then
  dunstify -i "$selected_file" "Wallpaper Changed" "Wallpaper set to $filename"
fi
