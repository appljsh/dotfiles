#!/bin/bash

# Primero intenta obtener metadata de Spotify
spotify_metadata=$(playerctl -p spotify metadata --format "{{ artist }} - {{ title }}" 2>/dev/null)

# Si Spotify no está reproduciendo, busca otros reproductores (Firefox, mpv, etc.)
if [ -z "$spotify_metadata" ]; then
    playerctl metadata --format "{{ artist }} - {{ title }}" || echo "No media"
else
    echo "$spotify_metadata"
fi
