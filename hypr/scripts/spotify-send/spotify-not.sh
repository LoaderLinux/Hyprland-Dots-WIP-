#!/bin/bash

CACHE_DIR="/tmp/spotify-cover"
mkdir -p "$CACHE_DIR"

LAST_SONG=""

while true; do
    status=$(playerctl --player=spotify status 2>/dev/null)

    if [[ "$status" == "Playing" ]]; then
        song=$(playerctl --player=spotify metadata --format '{{artist}} - {{title}}')

        if [[ "$song" != "$LAST_SONG" ]]; then
            LAST_SONG="$song"

            album_url=$(playerctl --player=spotify metadata mpris:artUrl 2>/dev/null)

            if [[ -n "$album_url" ]]; then
                album_art="$CACHE_DIR/cover.jpg"
                curl -s "$album_url" --output "$album_art"
            else
                album_art="/usr/share/icons/hicolor/256x256/apps/spotify.png"  # Fallback icon
            fi

            notify-send -t 2000 "Now Playing" "$song" --icon="$album_art"
        fi
    fi

    sleep 1
done

