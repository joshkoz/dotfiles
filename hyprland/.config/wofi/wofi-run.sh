#!/bin/bash
CONFIG="$HOME/.config/wofi/config"
STYLE="$HOME/.config/wofi/style.css"

if [[ ! $(pidof wofi) ]]; then
    wofi --conf "${CONFIG}" --style "${STYLE}" --width 700 --height 420 --hide-scroll
else
    pkill wofi
fi
