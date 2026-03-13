
#!/usr/bin/env bash
# generate-wallpaper-splits.sh

wallpaper_directory="$HOME/Pictures/wallpapers/"
split_directory="$HOME/Pictures/wallpapers/splits/"

# Create splits directory if it doesn't exist
mkdir -p "$split_directory"

# Process all images in wallpapers directory
find "$wallpaper_directory" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | while read -r image; do
  # Get image dimensions
  dimensions=$(identify -format "%w %h" "$image")
  width=$(echo $dimensions | cut -d' ' -f1)
  height=$(echo $dimensions | cut -d' ' -f2)
  
  # Calculate aspect ratio using awk
  aspect_ratio=$(awk "BEGIN {printf \"%.2f\", $width / $height}")
  is_wide=$(awk "BEGIN {print ($width / $height > 2.5) ? 1 : 0}")
  
  # Only split if aspect ratio > 2.5 (wide images)
  if [ "$is_wide" -eq 1 ]; then
    filename=$(basename "$image")
    name="${filename%.*}"
    ext="${filename##*.}"
    
    # Check if splits already exist
    if [ -f "$split_directory/${name}-left.${ext}" ] && [ -f "$split_directory/${name}-right.${ext}" ]; then
      echo "Skipping $filename (splits already exist)"
      continue
    fi
    
    echo "Splitting $filename (${width}x${height}, ratio: ${aspect_ratio})"
    
    half_width=$((width / 2))
    
    # Split image using ffmpeg
    ffmpeg -i "$image" -vf "crop=${half_width}:${height}:0:0" -y "$split_directory/${name}-left.${ext}" 2>/dev/null &
    ffmpeg -i "$image" -vf "crop=${half_width}:${height}:${half_width}:0" -y "$split_directory/${name}-right.${ext}" 2>/dev/null &
    wait
    
    echo "Created ${name}-left.${ext} and ${name}-right.${ext}"
  else
    echo "Skipping $filename (${width}x${height}, ratio: ${aspect_ratio}) - not wide enough"
  fi
done

echo "Done! Split wallpapers are in $split_directory"
