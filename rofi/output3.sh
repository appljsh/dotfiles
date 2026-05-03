#!/usr/bin/env bash


# Current Theme
dir="$HOME/.config/rofi/output3"
theme='output'

# CMDs
uptime="`uptime -p | sed -e 's/up //g'`"
host=`hostname`

# Options
headphones='  headphones'
monitor='󰍹  monitor'
speaker='󰓃 speaker'

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-p " Select output:" \
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
	echo -e "$headphones\n$monitor\n$speaker" | rofi_cmd
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $headphones)
		pactl set-default-sink alsa_output.pci-0000_0b_00.4.analog-stereo & play '~/Music/Sounds/tut.mp3' &
        ;;
    $monitor)
    pactl set-default-sink alsa_output.pci-0000_08_00.1.hdmi-stereo & play '~/Music/Sounds/tut.mp3' &
        ;;
    $speaker)
    pactl set-default-sink bluez_output.10_28_74_E7_FA_F0.1 & play '~/Music/Sounds/tut.mp3' &
        ;;
esac
