#!/bin/bash
# Check if hyprlock is already running
if pidof hyprlock > /dev/null; then
    exit 0
fi

# Function to set LockedHint
set_locked_hint() {
    local locked=$1
    # Get current session ID dynamically
    # Issue: https://github.com/hyprwm/hyprlock/issues/907
    SESSION_PATH=$(loginctl show-user $(whoami) -p Display --value)
    if [ -z "$SESSION_PATH" ]; then
        # Fallback: get first session for current user
        SESSION_ID=$(loginctl list-sessions --no-legend | grep "$(whoami)" | awk '{print $1}' | head -n1)
        SESSION_PATH="/org/freedesktop/login1/session/${SESSION_ID}"
    else
        SESSION_PATH="/org/freedesktop/login1/session/${SESSION_PATH}"
    fi
    busctl call org.freedesktop.login1 "$SESSION_PATH" org.freedesktop.login1.Session SetLockedHint b $locked
}

# Set locked before running hyprlock
set_locked_hint true

# Lock 1Password if it's running
if pidof 1password > /dev/null; then
    1password --lock
fi

# Run hyprlock (blocks until unlocked)
hyprlock $@

# Set unlocked after hyprlock exits
set_locked_hint false
