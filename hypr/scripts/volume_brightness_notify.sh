#!/bin/bash

# Function to send notification for volume
notify_volume() {
    VOL=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -1)
    MUTE=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -oP 'yes|no')

    if [[ "$MUTE" == "yes" ]]; then
        notify-send -r 91190 -u low "🔇 Volume muted"
    else
        notify-send -r 91190 -u low "🔊 Volume: $VOL"
    fi
}

# Function to send notification for brightness
notify_brightness() {
    BRIGHT=$(brightnessctl g)
    MAX_BRIGHT=$(brightnessctl m)
    PERCENT=$(( BRIGHT * 100 / MAX_BRIGHT ))
    notify-send -r 91191 -u low "💡 Brightness: ${PERCENT}%"
}

# Check action type
case "$1" in
    volume-up)
        pactl set-sink-volume @DEFAULT_SINK@ +5% && notify_volume
        ;;
    volume-down)
        pactl set-sink-volume @DEFAULT_SINK@ -5% && notify_volume
        ;;
    mute)
        pactl set-sink-mute @DEFAULT_SINK@ toggle && notify_volume
        ;;
    brightness-up)
        brightnessctl set +10% && notify_brightness
        ;;
    brightness-down)
        brightnessctl set 10%- && notify_brightness
        ;;
    *)
        echo "Usage: $0 {volume-up|volume-down|mute|brightness-up|brightness-down}"
        exit 1
        ;;
esac

