#!/usr/bin/env bash
set -euo pipefail

case "${1:-}" in
  toggle)
    exec wofi --show drun
    ;;
  *)
    echo "Usage: launcher.sh toggle" >&2
    exit 2
    ;;
esac
