#!/usr/bin/env bash
set -euo pipefail

# Load XDG user dirs if present
[[ -f "${HOME}/.config/user-dirs.dirs" ]] && source "${HOME}/.config/user-dirs.dirs"

# Resolve output directory
OUTPUT_DIR="${OMARCHY_SCREENSHOT_DIR:-${XDG_PICTURES_DIR:-$HOME/Pictures}}"

if [[ ! -d "$OUTPUT_DIR" ]]; then
  notify-send "Screenshot directory does not exist: $OUTPUT_DIR" -u critical -t 3000 || true
  exit 1
fi

# Selection mode: area | active | screen
MODE="${1:-area}"

# Timestamped filename
FNAME="screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png"
OUTPATH="${OUTPUT_DIR}/${FNAME}"

# Clipboard command for Wayland (Required for Satty)
COPY_CMD='wl-copy'

play_sound() {
  local SOUND_FILE="/usr/share/sounds/freedesktop/stereo/camera-shutter.oga"
  [[ -f "$SOUND_FILE" ]] || return 0

  (
    pw-play "$SOUND_FILE" --volume=0.4 \
      </dev/null >/dev/null 2>&1
  ) &
}

capture() {
  case "$MODE" in
    area)
      # We play the sound AFTER the selection is made
      grimblast --freeze save area - 
      ;;
    window|active)
      grimblast --freeze save active -
      ;;
    output|full|fullscreen)
      grimblast --freeze save screen -
      ;;
    *)
      notify-send "Invalid screenshot mode" -u critical
      exit 2
      ;;
  esac
}

capture_and_chirp() {
  # 1. Run the capture. This blocks until you finish selecting the area.
  capture
  
  # 2. As soon as selection is done, fire the sound in the background
  # and immediately exit the function so Satty gets the data.
  play_sound 
}

# Pipe into satty
capture_and_chirp | satty \
  --filename - \
  --output-filename "$OUTPATH" \
  --early-exit \
  --actions-on-enter save-to-clipboard \
  --initial-tool brush \
  --copy-command "$COPY_CMD"

# Notify success if the file was actually saved (Satty can exit without saving)
if [[ -f "$OUTPATH" ]]; then
  notify-send "Screenshot saved" "$OUTPATH" -i "$OUTPATH" -t 2000 || true
fi
