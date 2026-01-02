#!/bin/bash

# Configuration
STEP="0.05"  # wpctl uses floating point (0.05 = 5%)
SOUND_FILE="/usr/share/sounds/freedesktop/stereo/audio-volume-change.oga"

# Function to get current volume (extracts 0.XX from "Volume: 0.XX")
get_vol() {
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}' | cut -d. -f1
}

case $1 in
    up)
        # Increase volume, but limit to 1.0 (100%)
        # Change 1.0 to 1.5 if you want the limit to be 150%
        wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ $STEP+
        wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
        ;;
    down)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ $STEP-
        ;;
    *)
        echo "Usage: $0 {up|down}"
        exit 1
        ;;
esac

# Get new volume for notification
VOLUME=$(get_vol)

# Send Notification
notify-send -a "System" -t 1000 -r 999 \
    -h int:value:"$VOLUME" \
    -h string:x-canonical-private-synchronous:volume \
    "Volume: ${VOLUME}%"

# Play the feedback sound
if [ -f "$SOUND_FILE" ]; then
    paplay "$SOUND_FILE" &
fi
