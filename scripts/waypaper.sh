#!/bin/bash
current_ws=$(hyprctl activeworkspace -j | jq -r '.id') 
hyprctl dispatch workspace 6 && play '~/Music/Sounds/wall.mp3' & 
waypaper 
sleep 0.2
hyprctl dispatch workspace "$current_ws" && play '~/Music/Sounds/close.mp3' & 
