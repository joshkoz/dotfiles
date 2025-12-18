#!/bin/bash
# List of device descriptions to exclude
declare -a exclude_list=(
    "fifine Microphone"
    "GA102 High Definition Audio Controller"
)
declare -A sink_map
active_sink=$(pactl get-default-sink)

# Build map: description -> sink name and preserve order
menu_entries=()
active_description=""

while IFS= read -r line; do
    if [[ $line == *Name:* ]]; then
        sink_name=$(echo "$line" | awk '{print $NF}')
    fi
    if [[ $line == *Description:* ]]; then
        description=$(echo "$line" | cut -d ':' -f2- | xargs)
        # Check exclusion
        exclude=false
        for exclude_item in "${exclude_list[@]}"; do
            if [[ $description == *"$exclude_item"* ]]; then
                exclude=true
                break
            fi
        done
        if [ "$exclude" = false ]; then
            sink_map["$description"]=$sink_name
            if [[ $sink_name == "$active_sink" ]]; then
                active_description=$description
            else
                menu_entries+=("$description")
            fi
        fi
    fi
done < <(pactl list sinks)

# Build numbered entries for display, with active sink first
display_entries=()
if [ -n "$active_description" ]; then
    display_entries+=("1. $active_description")
    counter=2
else
    counter=1
fi

for entry in "${menu_entries[@]}"; do
    display_entries+=("$counter. $entry")
    ((counter++))
done

# Show menu
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    menu=$(printf '%s\n' "${display_entries[@]}" | wofi --dmenu -i -p "🕪 Audio Output")
else
    menu=$(printf '%s\n' "${display_entries[@]}" | rofi -dmenu -i -p "🕪" -no-sort)
fi

# Strip the number prefix from selection
menu=$(echo "$menu" | sed 's/^[0-9]*\. //')

# Trim whitespace
menu=$(echo "$menu" | xargs)

# Fallback to active sink if nothing selected
if [ -z "$menu" ]; then
    menu=$active_description
fi

# Set selected sink
selected_sink=${sink_map[$menu]}
if [ -n "$selected_sink" ]; then
    pactl set-default-sink "$selected_sink"
    pactl list short sink-inputs | cut -f1 | while read -r input; do
        pactl move-sink-input "$input" "$selected_sink"
    done
fi
