#!/bin/bash


# nasa-wallpaper -q earth -d $(date -d "yesterday" '+%Y-%m-%d') 

# Directory containing wallpapers
wallpaper_directory="/home/joshua/Pictures/wallpapers/"

# Select a random file from the directory
# uncooment the below to randomise 
if [ -z "$1" ]; then
  selected_file=$(find "$wallpaper_directory" -type f | shuf -n 1)
  dunstify -i "$selected_file" "Wallpaper Changed" "Wallpaper set to $filename"
else
  selected_file=$1
fi
# selected_file=/home/joshua/Pictures/wallpapers/karman-line-wide.jpg

# Set the selected file as the wallpaper
# Replace 'feh' with your wallpaper setting command if different
feh --bg-scale --no-xinerama "$selected_file"

# Extract filename from the path
filename=$(basename "$selected_file")

# Send notification with Dunst
# Note: Dunst may have limitations on image sizes and types it can display


