
hyprctl dispatch exec [workspace 3 silent] "kitty --config ~/.config/kitty/msg.conf -e  --override cursor_trail=0 --title=karane1  ~/.config/scripts/greetings2" & hyprctl dispatch exec [workspace 3 silent] "kitty --config ~/.config/kitty/msg.conf -e --override font_size=35 --override cursor_trail=0 --title=greeting  ~/.config/scripts/greetings" & hyprctl dispatch exec [workspace 3 silent] "feh Downloads/karane2.png " &
sleep 2.5
killall -9 feh