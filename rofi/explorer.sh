#!/usr/bin/env bash


# Current Theme
dir="$HOME/.config/rofi/explorer"
theme='explorer'

# CMDs
uptime="`uptime -p | sed -e 's/up //g'`"
host=`hostname`

# Options
downloads='   Downloads'
pictures='   Pictures'
screenshots='󰹑   Screenshots'
sounds='   Sounds'
configs='   Configs'
school='   School Files'
wallpapers='󰸉   Wallpapers'
sync='   Syncthing'



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
    width:                       250px;
    height:                      130px;
    x-offset:                     0px;
    y-offset:                     0px;
    border:                       2px;
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
	echo -e "$downloads\n$pictures\n$screenshots\n$sounds\n$configs\n$school\n$wallpapers\n$sync" | rofi_cmd
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $downloads)
		nemo ~/Downloads & play '~/Music/Sounds/tut.mp3' &
        ;;
    $pictures)
		nemo ~/Pictures & play '~/Music/Sounds/tut.mp3' &
        ;;
    $screenshots)
		nemo ~/Pictures/Screenshots & play '~/Music/Sounds/tut.mp3' &
        ;;
    $sounds)
		nemo ~/Music/Sounds & play '~/Music/Sounds/tut.mp3' &
        ;;
    $configs)
		nemo ~/.config & play '~/Music/Sounds/tut.mp3' &
        ;;
    $school)
		nemo ~/school-archives & play '~/Music/Sounds/tut.mp3' &
        ;;
    $wallpapers)
		nemo ~/Waslync & play '~/Music/Sounds/tut.mp3' &
        ;;
    $sync)
		nemo ~/Syncthings & play '~/Music/Sounds/tut.mp3' &
        ;;
*) # Esto se ejecuta si $chosen no coincide con ninguno de los anteriores
        play '~/Music/Sounds/cancel.mp3' &
        ;;
esac
