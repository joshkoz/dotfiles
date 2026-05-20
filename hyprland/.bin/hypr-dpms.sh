#!/bin/bash

set -u

ACTION="${1:-on}"

case "$ACTION" in
    on|off|toggle)
        ;;
    enable)
        ACTION="on"
        ;;
    disable)
        ACTION="off"
        ;;
    *)
        echo "Usage: $0 {on|off|toggle}" >&2
        exit 1
        ;;
esac

DISPATCH="hl.dsp.dpms({ action = \"$ACTION\" })"
RETRIES="${HYPR_DPMS_RETRIES:-12}"
DELAY="${HYPR_DPMS_DELAY:-0.25}"

for _ in $(seq 1 "$RETRIES"); do
    if hyprctl dispatch "$DISPATCH" >/dev/null 2>&1; then
        exit 0
    fi
    sleep "$DELAY"
done

hyprctl dispatch "$DISPATCH"
