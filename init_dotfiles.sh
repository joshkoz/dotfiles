#!/bin/bash

# Check if stow is installed
if ! command -v stow &> /dev/null; then
    echo "Stow not found. Please install stow."
    exit 1
fi

# Loop through directories
for dir in */ ; do
    echo "Stowing $dir"
    stow -v -R -t ~ "${dir}"
done

echo "All done."

