#!/usr/bin/env bash
# Noctalia wallpaper_changed/started hook: keep hyprlock's per-monitor backgrounds
# (~/.current-wallpaper-left / -right, see hypr/hyprlock.conf) in step with the
# spanned Noctalia wallpaper. Wide images are cut in half once and cached; anything
# else is used whole on both monitors. DP-1 is the left monitor, DP-2 the right.
set -euo pipefail

wallpaper="${NOCTALIA_WALLPAPER_PATH:-}"
[[ -n "$wallpaper" ]] || wallpaper="$(noctalia msg wallpaper-get 2>/dev/null || true)"
[[ -f "$wallpaper" ]] || exit 0 # solid colours (color:#...) and missing files: leave the links alone

cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/wallpaper-splits"
mkdir -p "$cache_dir"

# The hook runs once per monitor for the same change; only one run does the work.
exec 9>"$cache_dir/.lock"
flock 9

left="$wallpaper"
right="$wallpaper"

IFS=x read -r width height < <(ffprobe -v error -select_streams v:0 -show_entries stream=width,height \
  -of csv=p=0:s=x "$wallpaper")

if (( width * 10 > height * 25 )); then # wider than 2.5:1 -> one image across both monitors
  filename="$(basename "$wallpaper")"
  name="${filename%.*}"
  ext="${filename##*.}"
  left="$cache_dir/$name-left.$ext"
  right="$cache_dir/$name-right.$ext"
  half=$((width / 2))
  [[ -f "$left" ]] || ffmpeg -v error -y -i "$wallpaper" -vf "crop=$half:$height:0:0" "$left"
  [[ -f "$right" ]] || ffmpeg -v error -y -i "$wallpaper" -vf "crop=$half:$height:$half:0" "$right"
fi

ln -sfn "$left" "$HOME/.current-wallpaper-left"
ln -sfn "$right" "$HOME/.current-wallpaper-right"
