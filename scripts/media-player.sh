#!/bin/bash
spotify_metadata=$(playerctl -p spotify metadata --format "{{ artist }} - {{ title }}" 2>/dev/null)

if [ -z "$spotify_metadata" ]; then
    playerctl metadata --format "{{ artist }} - {{ title }}" || echo "No media"
else
    echo "$spotify_metadata"
fi
