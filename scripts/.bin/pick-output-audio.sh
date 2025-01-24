
#!/bin/bash

# List of device descriptions to exclude
declare -a exclude_list=(
    "fifine Microphone"
    # "MH752"
    # "Family 17h/19h HD Audio Controller"
    "GA102 High Definition Audio Controller"
)

declare -A sink_map
active_sink=$(pactl get-default-sink)

while IFS= read -r line; do
    # Extract the sink name
    if [[ $line == *Name:* ]]; then
        sink_name=$(echo "$line" | awk '{print $NF}')
    fi

    # Extract and map the description to the sink name
    if [[ $line == *Description:* ]]; then
        description=$(echo "$line" | cut -d ':' -f2- | xargs)

        # Check if this sink should be excluded
        exclude=false
        for exclude_item in "${exclude_list[@]}"; do
             if [[ $description == *"$exclude_item"* ]]; then
                exclude=true
                break
            fi
        done

        if [ "$exclude" = false ]; then
            sink_map["$description"]=$sink_name
        fi
    fi
done < <(pactl list sinks)

# Prepare the menu entries, putting the active sink first
menu_entries=()
active_description=""

for description in "${!sink_map[@]}"; do
    if [[ ${sink_map[$description]} == "$active_sink" ]]; then
        active_description=$description
    else
        menu_entries+=("$description")
    fi
done

# If there is an active sink, prepend it to the menu entries
if [ -n "$active_description" ]; then
    menu_entries=("$active_description" "${menu_entries[@]}")
fi

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    echo "Session type is Wayland."
    menu=$(printf '%s\n' "${menu_entries[@]}" | wofi --dmenu -i -p "🕪")
else
    menu=$(printf '%s\n' "${menu_entries[@]}" | rofi -dmenu -i -p "🕪")
fi
# Generate the menu with descriptions

# Get the selected sink name and set it as the default
selected_sink=${sink_map[$menu]}
if [ -n "$selected_sink" ]; then
    pactl set-default-sink "$selected_sink"
    pactl list short sink-inputs | cut -f1 | while read -r input; do
        pactl move-sink-input "$input" "$selected_sink"
    done
fi
