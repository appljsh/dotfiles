#!/usr/bin/env bash


# Current Theme
dir="$HOME/.config/rofi/powermenu"
theme='style-3'

# CMDs
uptime="`uptime -p | sed -e 's/up //g'`"
host=`hostname`

# Options
shutdown='󰐥'
reboot=''
lock=''
suspend=''
logout='󰈆'
yes=''
no=''

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-p "Uptime: $uptime" \
		-mesg "Uptime: $uptime" \
		-theme ${dir}/${theme}.rasi
}

# Confirmation CMD
confirm_cmd() {
	rofi -theme-str 'window {
    /* properties for window widget */
    transparency:                "real";
    location:                    east;
    anchor:                      center;
    fullscreen:                  false;
    width:                       90px;
    height:                      180px;
    x-offset:                     -20px;
    y-offset:                     0px;
    border:                      1px solid;
    border-color:                #ffffff38;

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
    columns:                     1;
    lines:                       2;
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
    padding:                     20px 0px;
    border-radius:               100%;
    background-color:            transparent;
    text-color:                  @foreground;
    cursor:                      pointer;
    orientation:                 vertical;
}' \
		-theme-str 'element-text {
    font:                        "fira code Nerd Font mono 19";
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

# Ask for confirmation
confirm_exit() {
	echo -e "$yes\n$no" | confirm_cmd
} 

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

# Execute Command
run_cmd() {
	selected="$(confirm_exit)"
	if [[ "$selected" == "$yes" ]]; then
		if [[ $1 == '--shutdown' ]]; then
			hyprctl dispatch exec "~/.config/scripts/shutdown.sh"
		elif [[ $1 == '--reboot' ]]; then
			hyprctl dispatch exec "~/.config/scripts/reboot.sh" 
		elif [[ $1 == '--suspend' ]]; then
			hyprctl dispatch exec "~/.config/scripts/suspend.sh"
		elif [[ $1 == '--logout' ]]; then
			hyprctl dispatch exec "~/.config/scripts/logout.sh"
		fi
	else
		play '~/Music/Sounds/no.mp3' & exit 0
	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
		run_cmd --shutdown & play '~/Music/Sounds/tut.mp3' &
        ;;
    $reboot)
		run_cmd --reboot & play '~/Music/Sounds/tut.mp3' &
        ;;
    $lock)
        hyprlock & play '~/Music/Sounds/tut.mp3' &
        ;;
    $suspend)
		run_cmd --suspend  & play '~/Music/Sounds/tut.mp3' &
        ;;
    $logout)
    	run_cmd --logout  & play '~/Music/Sounds/tut.mp3' &
        ;;
*) # Esto se ejecuta si $chosen no coincide con ninguno de los anteriores
        play '~/Music/Sounds/no.mp3' &
        ;;
esac
