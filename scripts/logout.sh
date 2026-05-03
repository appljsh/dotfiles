
hyprctl dispatch workspace 9
hyprctl dispatch exec sleep 3 && play '~/Music/Sounds/shutdown.mp3' & 
hyprctl dispatch exec [workspace 9 silent] "kitty --config ~/.config/kitty/msg.conf -e --override font_size=35 --override cursor_trail=0 --title=goodbye  ~/.config/scripts/goodbye" &
sleep 0.5
sleep 3
hyprctl dispatch exit