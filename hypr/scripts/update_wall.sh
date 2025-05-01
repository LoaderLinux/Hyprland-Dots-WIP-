#!/bin/bash

# Path to save the current wallpaper copy
TARGET="$HOME/.current_wallpaper.png"

# Get the current wallpaper from swww
CURRENT=$(swww query | grep 'image:' | awk -F'image: ' '{print $2}' | xargs)

# Only copy if the wallpaper has changed
if [[ "$CURRENT" != "" && -f "$CURRENT" ]]; then
    cp "$CURRENT" "$TARGET"
fi

