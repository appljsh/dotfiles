#!/bin/bash

# Toggle the mute state of the default source
pactl set-source-mute @DEFAULT_SOURCE@ toggle

# Get the current mute status and volume
MUTE_STATUS=$(pactl get-source-mute @DEFAULT_SOURCE@ | grep -n 'yes'| awk '{print $2}')
VOLUME=$(pactl list sources | grep -A 10 'Source #' | grep 'Volume:' | head -n 1 | awk '{print $3}' | cut -d '/' -f 2)

# Send a desktop notification (requires 'notify-send' to be installed)
if [ "$MUTE_STATUS" = "yes" ]; then
    play '/home/denko/Music/Sounds/close.mp3'  
else
    play '/home/denko/Music/Sounds/wall.mp3'  
fi