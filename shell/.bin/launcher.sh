#!/usr/bin/env bash
set -euo pipefail

config_home="${XDG_CONFIG_HOME:-$HOME/.config}"
wofi_args=(
  --conf "$config_home/wofi/config"
  --style "$config_home/wofi/style.css"
  --width 700
  --height 420
  --hide-scroll
)

case "${1:-}" in
  toggle)
    exec wofi "${wofi_args[@]}" --show drun
    ;;
  *)
    echo "Usage: launcher.sh toggle" >&2
    exit 2
    ;;
esac
