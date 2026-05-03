#!/bin/bash
pkill -x waybar
sleep 0.2
~/.config/scripts/waybar.sh &
if command -v notify-send &> /dev/null; then
    notify-send -i ~/Downloads/arch.png "Waybar Realoaded" "The status bar has been reloaded." && play '~/Music/Sounds/noti.mp3' & 
fi

exit 0
