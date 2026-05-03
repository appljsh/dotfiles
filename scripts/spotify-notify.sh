#!/bin/bash

player="spotify"

playerctl --player=$player metadata --format '{{title}}|{{artist}}|{{mpris:artUrl}}' --follow |
  while IFS="|" read -r title artist artUrl; do
    # Descargar la portada (si existe)
    iconPath="/tmp/spotify_cover.jpg"
    if [[ $artUrl == http* ]]; then
      curl -s "$artUrl" -o "$iconPath"
    fi

    # Mostrar notificación con carátula
    notify-send -i "$iconPath" "$artist" "$title"
  done
