#!/bin/bash

hyprctl dispatch exec pactl set-source-mute @DEFAULT_SOURCE@ toggle 

MUTE_STATUS=$(pactl get-source-mute @DEFAULT_SOURCE@ | grep -n 'yes'| awk '{print $2}')
VOLUME=$(pactl list sources | grep -A 10 'Source #' | grep 'Volume:' | head -n 1 | awk '{print $3}' | cut -d '/' -f 2)

if [ "$MUTE_STATUS" = "yes" ]; then
    play '/home/denko/Music/Sounds/wall.mp3'  
else
    play '/home/denko/Music/Sounds/close.mp3'  
fi
