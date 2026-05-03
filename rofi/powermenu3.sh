#!/usr/bin/env bash


# Current Theme
dir="$HOME/.config/rofi/powermenu"
theme='style-33'

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
    x-offset:                     -75px;
    y-offset:                     0px;
    border:                       2px;
    border-color:                 @active;

    /* properties for all widgets */
    enabled:                     true;
    border-radius:               0;
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
    border-radius:               0;
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
    border-radius:               0;
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
			shutdown now
		elif [[ $1 == '--reboot' ]]; then
			reboot 
		elif [[ $1 == '--suspend' ]]; then
			hyprctl dispatch exec "~/.config/scripts/suspend.sh"
		elif [[ $1 == '--logout' ]]; then
			 i3-msg exit
		fi
	else
		 exit 0
	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
		run_cmd --shutdown 
        ;;
    $reboot)
		run_cmd --reboot 
        ;;
    $lock)
        ~/.config/scripts/hyprlock.sh

        ;;
    $suspend)
		run_cmd --suspend  
        ;;
    $logout)
    	run_cmd --logout  
        ;;
esac
