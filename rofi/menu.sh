#!/usr/bin/env bash


# Current Theme
dir="$HOME/.config/rofi/menu"
theme='menu'

# CMDs
uptime="`uptime -p | sed -e 's/up //g'`"
host=`hostname`

# Options
explorer='   Files'
output='   Output'
settings='   Settings'
SD='󰑹   Import SD'
wallpaper='󰸉   Change Wallpaper'
sync='   Sync'



# Rofi CMD
rofi_cmd() {
	rofi -dmenu -i \
		-p "Open:" \
		-theme ${dir}/${theme}.rasi
}

# Confirmation CMD
confirm_cmd() {
	rofi -theme-str 'window {
    /* properties for window widget */
    transparency:                "real";
    location:                    center;
    anchor:                      center;
    fullscreen:                  false;
    width:                       220px;
    height:                      130px;
    x-offset:                     0px;
    y-offset:                     0px;
    border:                       0fpx;
    border-color:                 @active;

    /* properties for all widgets */
    enabled:                     true;
    border-radius:               100%;
    cursor:                      "default";
    background-color:            @background;
}' \
		-theme-str 'mainbox {
    enabled:                     true;
    spacing:                     0px;
    background-color:            transparent;
    orientation:                 vertical;
    children:                    ["listview" ];
}' \
		-theme-str 'listview {
    enabled:                     true;
    columns:                     2;
    lines:                       1;
    cycle:                       true;
    dynamic:                     true;
    scrollbar:                   false;
    layout:                      vertical;
    reverse:                     false;
    fixed-height:                true;
    fixed-columns:               true;
    
    spacing:                     10px;
    margin:                      2px;
    padding:                     5px;
    border:                      0px solid;
    border-radius:               100%;
    border-color:                @selected;
    background-color:            transparent;
    text-color:                  @foreground;
    cursor:                      "default";
}' \
		-theme-str 'element {
    font:                        "SF Pro Regular 2";
    enabled:                     true;
    spacing:                     50px;
    padding:                     25px 10px;
    border-radius:               100%;
    background-color:            transparent;
    text-color:                  @foreground;
    cursor:                      pointer;
    orientation:                 vertical;
}' \
		-theme-str 'element-text {
    font:                        "fira code Nerd Font mono 30";
    background-color:            transparent;
    text-color:                  inherit;
    cursor:                      inherit;
    vertical-align:              1;
    horizontal-align:            0.5;
}' \
		-dmenu \
		-p 'Confirmation' \
		-mesg 'Are you Sure?' \
		-theme ${dir}/${theme}.rasi
}


# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$explorer\n$output\n$settings\n$SD\n$wallpaper\n$sync" | rofi_cmd
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $explorer)
		~/.config/rofi/explorer.sh & play '~/Music/Sounds/tut.mp3' &
        ;;
    $output)
		~/.config/rofi/output.sh & play '~/Music/Sounds/tut.mp3' &
        ;;
    $settings)
		~/.config/rofi/settings.sh & play '~/Music/Sounds/tut.mp3' &
        ;;
    $SD)
		~/.config/scripts/sd.sh & play '~/Music/Sounds/tut.mp3' &
        ;;
    $wallpaper)
		~/.config/scripts/waypaper.sh
        ;;
    $sync)
    zen-browser 'https://127.0.0.1:8384/#'  & play '~/Music/Sounds/tut.mp3' &   
       ;;
*) # Esto se ejecuta si $chosen no coincide con ninguno de los anteriores
        play '~/Music/Sounds/cancel.mp3' &
        ;;
esac
