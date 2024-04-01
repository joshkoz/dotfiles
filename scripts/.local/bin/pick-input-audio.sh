#!/bin/bash

# List of device descriptions to exclude
declare -a exclude_list=(
    # "fifine Microphone"
    # "MH752"
    # "Family 17h/19h HD Audio Controller"
    # "GA102 High Definition Audio Controller"
)

declare -A source_map
active_source=$(pactl get-default-source)

while IFS= read -r line; do
    # Extract the source name
    if [[ $line == *Name:* ]]; then
        source_name=$(echo "$line" | awk '{print $NF}')
    fi

    # Extract and map the description to the source name
    if [[ $line == *Description:* ]]; then
        description=$(echo "$line" | cut -d ':' -f2- | xargs)

        # Check if this source should be excluded
        exclude=false
        for exclude_item in "${exclude_list[@]}"; do
             if [[ $description == *"$exclude_item"* ]]; then
                exclude=true
                break
            fi
        done

        if [ "$exclude" = false ]; then
            source_map["$description"]=$source_name
        fi
    fi
done < <(pactl list sources)

# Prepare the menu entries, putting the active source first
menu_entries=()
active_description=""

for description in "${!source_map[@]}"; do
    if [[ ${source_map[$description]} == "$active_source" ]]; then
        active_description=$description
    else
        menu_entries+=("$description")
    fi
done

# If there is an active source, prepend it to the menu entries
if [ -n "$active_description" ]; then
    menu_entries=("$active_description" "${menu_entries[@]}")
fi

# Generate the menu with descriptions
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    echo "Session type is Wayland."
    menu=$(printf '%s\n' "${menu_entries[@]}" | wofi --dmenu -i -p "Select Audio Source:")
else
    menu=$(printf '%s\n' "${menu_entries[@]}" | rofi -dmenu -i -p "Select Audio Source:")
fi

# Get the selected source name and set it as the default
selected_source=${source_map[$menu]}
if [ -n "$selected_source" ]; then
    pactl set-default-source "$selected_source"
    pactl list short source-outputs | cut -f1 | while read -r output; do
        pactl move-source-output "$output" "$selected_source"
    done
fi

