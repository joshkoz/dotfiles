#!/bin/bash

declare -A sink_map
while IFS= read -r line; do
    # Extract the sink name
    if [[ $line == *Name:* ]]; then
        sink_name=$(echo "$line" | awk '{print $NF}')
    fi

    # Extract and map the description to the sink name
    if [[ $line == *Description:* ]]; then
        description=$(echo "$line" | cut -d ':' -f2- | xargs)
        sink_map["$description"]=$sink_name
    fi
done < <(pactl list sinks | grep -vi GA102 | grep -vi family)

# Generate a menu with descriptions
menu=$(for key in "${!sink_map[@]}"; do echo "$key"; done | rofi -dmenu -i -p "Select Audio Input Device:")

# Get the selected sink name and set it as the default
selected_sink=${sink_map[$menu]}
if [ -n "$selected_sink" ]; then
    pactl set-default-sink "$selected_sink"
    pactl list short sink-inputs | cut -f1 | while read -r input; do
        pactl move-sink-input "$input" "$selected_sink"
    done
fi

