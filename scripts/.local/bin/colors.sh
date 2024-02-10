#!/bin/bash

set -e 

# Define colors
colors=(
"Red #FF0000"
"Green #00FF00"
"Blue #0000FF"
"Yellow #FFFF00"
"Cyan #00FFFF"
"Magenta #FF00FF"
"kanagawa_bg #1f1f28"
"kanagawa_fg #dcd7ba"
"kanagawa_cyan #6a9589"
"kanagawa_black #090618"
"kanagawa_gray #363646"
"kanagawa_magenta #957fb8"
"kanagawa_pink #938aa9"
"kanagawa_red #"
"kanagawa_green #76946a"
"kanagawa_yellow #c0a36e"
"kanagawa_blue #7e9cd8"
"kanagawa_orange #ffa066"
"kanagawa_altblack #727169"
)

# Convert array to a newline-separated string
color_list=$(printf "%s\n" "${colors[@]}")

# Use fzf with a preview window at the bottom
selected_color=$(echo "$color_list" | fzf --preview 'echo {} | awk "{split(\$NF,a,\"#\"); r=strtonum(\"0x\" substr(a[2],1,2)); g=strtonum(\"0x\" substr(a[2],3,2)); b=strtonum(\"0x\" substr(a[2],5,2)); printf \"\033[48;2;%d;%d;%dm%20s\033[0m\n\", r, g, b, \"\" }"' --preview-window "bottom:50%:wrap")

# Extract the hex code from the selection
hex_code=$(echo "$selected_color" | awk '{print $NF}')

echo "Selected color hex code: $hex_code"

hex=$(echo $hex_code | sed 's/#//') 

blue="0000ff"

motherboard=0
graphicscard=1
desklamp=3

openrgb \
    -d $desklamp -c $hex \
    -d $motherboard -c $blue \
    -d $graphicscard -c $blue

