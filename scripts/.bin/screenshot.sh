#!/usr/bin/env bash
set -euo pipefail

# Load XDG user dirs if present
[[ -f "${HOME}/.config/user-dirs.dirs" ]] && source "${HOME}/.config/user-dirs.dirs"

# Resolve output directory
OUTPUT_DIR="${OMARCHY_SCREENSHOT_DIR:-${XDG_PICTURES_DIR:-$HOME/Pictures}}"

if [[ ! -d "$OUTPUT_DIR" ]]; then
  notify-send "Screenshot directory does not exist: $OUTPUT_DIR" -u critical -t 3000 || true
  echo "Screenshot directory does not exist: $OUTPUT_DIR" >&2
  exit 1
fi

# Selection mode: region | window | output (fullscreen)
MODE="${1:-region}"

# Timestamped filename
FNAME="screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png"
OUTPATH="${OUTPUT_DIR}/${FNAME}"

# Clipboard command for X11
COPY_CMD='xclip -selection clipboard -t image/png -i'

# Take the screenshot to stdout with maim based on mode
screenshot() {
  case "$MODE" in
    region)
      maim -s -u
      ;;
    window)
      WIN_ID="$(xdotool getactivewindow)"
      maim -u -i "$WIN_ID"
      ;;
    output|full|fullscreen)
      maim -u
      ;;
    *)
      notify-send "Invalid screenshot mode: $MODE" -u critical -t 3000 || true
      echo "Invalid screenshot mode: $MODE" >&2
      exit 2
      ;;
  esac
}

# Pipe into satty for annotation and saving+copying
screenshot | GDK_SCALE=2  GTK_THEME=Adwaita:dark satty \
  --filename - \
  --output-filename "$OUTPATH" \
  --early-exit \
  --actions-on-enter save-to-clipboard \
  --initial-tool brush \
  --copy-command "$COPY_CMD"

# Notify success
if [[ -f "$OUTPATH" ]]; then
  notify-send "Screenshot saved" "$OUTPATH" -t 2000 || true
fi
