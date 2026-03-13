#!/usr/bin/env bash

wallpaper_directory="$HOME/Pictures/wallpapers/"
split_directory="$HOME/Pictures/wallpapers/splits/"

# Symlink paths
left_link="$HOME/.current-wallpaper-left"
right_link="$HOME/.current-wallpaper-right"

# Select wallpaper (random or specified)
if [ -z "$1" ]; then
  selected_file=$(find "$wallpaper_directory" -maxdepth 1 -type f | shuf -n 1)
else
  selected_file=$1
fi

# Extract filename components
filename=$(basename "$selected_file")
name="${filename%.*}"
ext="${filename##*.}"

# Check if splits exist
left_split="$split_directory/${name}-left.${ext}"
right_split="$split_directory/${name}-right.${ext}"

# Detect if running Wayland or X11
if [ -n "$WAYLAND_DISPLAY" ]; then
  echo "Detected Wayland, using hyprpaper"
  
  if ! pgrep -x hyprpaper > /dev/null; then
    hyprpaper &
    sleep 1
  fi
  
  monitors=($(hyprctl monitors -j | jq -r '.[].name'))
  hyprctl hyprpaper unload all
  
  if [ -f "$left_split" ] && [ -f "$right_split" ]; then
    echo "Using pre-split images"
    
    # Create symlinks ( -s for symbolic, -f to force overwrite, -n to treat link as file)
    ln -sf "$left_split" "$left_link"
    ln -sf "$right_split" "$right_link"
    
    hyprctl hyprpaper preload "$left_split"
    hyprctl hyprpaper preload "$right_split"
    
    if [ ${#monitors[@]} -ge 2 ]; then
      hyprctl hyprpaper wallpaper "${monitors[0]},$left_split"
      hyprctl hyprpaper wallpaper "${monitors[1]},$right_split"
    else
      hyprctl hyprpaper wallpaper "${monitors[0]},$left_split"
    fi
  else
    echo "Using original image on all monitors"
    
    # Point both symlinks to the same original file
    ln -sf "$selected_file" "$left_link"
    ln -sf "$selected_file" "$right_link"
    
    hyprctl hyprpaper preload "$selected_file"
    for monitor in "${monitors[@]}"; do
      hyprctl hyprpaper wallpaper "$monitor,$selected_file"
    done
  fi

else
  # X11 - use feh
  echo "Detected X11, using feh"
  
  if [ -f "$left_split" ] && [ -f "$right_split" ]; then
    ln -sf "$left_split" "$left_link"
    ln -sf "$right_split" "$right_link"
    feh --bg-fill "$left_split" "$right_split"
  else
    ln -sf "$selected_file" "$left_link"
    ln -sf "$selected_file" "$right_link"
    feh --bg-scale --no-xinerama "$selected_file"
  fi
fi

# Notification
if [ -z "$1" ]; then
  dunstify -i "$selected_file" "Wallpaper Changed" "Wallpaper set to $filename"
fi
