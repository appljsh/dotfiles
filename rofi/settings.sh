#!/usr/bin/env bash


# Current Theme
dir="$HOME/.config/rofi/settings"
theme='settings'

# CMDs
uptime="`uptime -p | sed -e 's/up //g'`"
host=`hostname`

# Options
startup='   Startup'
windowrules='   Windowrules'
keybinds='   Keybinds'
waybar='   Waybar'
zsh='   Zsh'
waybarstyle='   Waybar Style'
hyprlock='   Hyprlock'
animations='   Animations'
decorations='   Decorations'
enviroments='   Enviroment Rules'
input='   Input'
monitors='   Monitors'
plugins='   Hyprplugins'


# Rofi CMD
rofi_cmd() {
	rofi -dmenu -i \
		-p " Settings:" \
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
	echo -e "$startup\n$windowrules\n$keybinds\n$animations\n$decorations\n$enviroments\n$input\n$monitors\n$plugins\n$waybar\n$waybarstyle\n$hyprlock\n$zsh" | rofi_cmd
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $startup)
		kitty -e nvim '~/.config/hypr/modules/startup.conf' & play '~/Music/Sounds/tut.mp3' &
        ;;
    $windowrules)
		kitty -e nvim '~/.config/hypr/modules/windowrules.conf' & play '~/Music/Sounds/tut.mp3' &
        ;;
    $keybinds)
		kitty -e nvim '~/.config/hypr/modules/keybinds.conf' & play '~/Music/Sounds/tut.mp3' &
        ;;
    $animations)
		kitty -e nvim '~/.config/hypr/modules/animation.conf' & play '~/Music/Sounds/tut.mp3' &
        ;;
    $decorations)
		kitty -e nvim '~/.config/hypr/modules/decorations.conf' & play '~/Music/Sounds/tut.mp3' &
        ;;
    $enviroments)
		kitty -e nvim '~/.config/hypr/modules/enviroment.conf' & play '~/Music/Sounds/tut.mp3' &
        ;;
    $input)
		kitty -e nvim '~/.config/hypr/modules/input.conf' & play '~/Music/Sounds/tut.mp3' &
        ;;
    $monitors)
		kitty -e nvim '~/.config/hypr/modules/monitors.conf' & play '~/Music/Sounds/tut.mp3' &
        ;;
    $plugins)
		kitty -e nvim '~/.config/hypr/modules/plugins.conf' & play '~/Music/Sounds/tut.mp3' &
        ;;
    $waybar)
		kitty -e nvim '~/.config/waybar/config.jsonc' & play '~/Music/Sounds/tut.mp3' &
        ;;
    $waybarstyle)
		kitty -e nvim .config/waybar/style.css & play '~/Music/Sounds/tut.mp3' &
       ;;
    $hyprlock)
		kitty -e nvim '~/.config/hypr/modules/plugins.conf' & play '~/Music/Sounds/tut.mp3' &
        ;;
    $zsh)
		kitty -e nvim '~/.zshrc' & play '~/Music/Sounds/tut.mp3' &
        ;;
*) 
        play '~/Music/Sounds/cancel.mp3' &
        ;;
esac