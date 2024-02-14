#!/bin/bash

{
    if [ -z "$TMUX" ]; then
        exit 1
    fi
    
    # Get the current tmux session name
    SESSION_NAME=$(tmux display-message -p '#S')

    # Define your session-color mappings
    declare -A session_colors
    session_colors["dotfiles"]="#76946a"
    session_colors["core-api"]="#938aa9"
    session_colors["second-brain"]="#7e9cd8"
    session_colors["work-vault"]="#ffa066"

    # Default color if session name doesn't match any key
    default_color="white"

    # Get the color for the current session, defaulting if not found
    COLOR="${session_colors[$SESSION_NAME]:-$default_color}"

    /home/joshua/.local/bin/colors.sh $COLOR 
} &> /dev/null

