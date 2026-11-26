#!/bin/bash

# Configuration
STEP="0.05"  # wpctl uses floating point (0.05 = 5%)
SOUND_FILE="/usr/share/sounds/freedesktop/stereo/audio-volume-change.oga"

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

# No notification here: Noctalia shows its own volume OSD whenever the volume changes

# Play the feedback sound
if [ -f "$SOUND_FILE" ]; then
    paplay "$SOUND_FILE" &
fi
