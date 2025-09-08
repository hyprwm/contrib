#!/usr/bin/env bash

## Author  : Aditya Shakya (adi1090x)
## Github  : @adi1090x
#
## Applets : Screenshot (Ported to use Grimblast)

## Modify
## Author  : Gonçalo Duarte (MrDuartePT)
## Github  : @MrDuartePT
##
## Github  : @Xartoks

## Port for Grimblast (https://github.com/hyprwm/contrib/tree/main/grimblast)menu_command=""

menu_command="walker"
# Options
main_opts=("󰹑 Capture" "󰁫 Timer capture")
screenshot_opts=("󰍺 All Screen" "󰍹 Active Screen" "󱣴 Capture Area")
timer_opts=("5s" "10s" "20s" "30s" "60s")
action_opts=(" Copy" " Save" " Copy &amp; Save" " Edit")

# Detect available menu program
define_menu() {
    if [[ -z $menu_command ]]; then
        if command -v wofi >/dev/null 2>&1; then
            menu_command="wofi"
        elif command -v rofi >/dev/null 2>&1; then
            menu_command="rofi"
        elif command -v walker >/dev/null 2>&1; then
            menu_command="walker"
        else
            echo "No menu program found (wofi, rofi, walker)" >&2
            exit 1
        fi
    fi
}

# Show menu based on detected command
show_menu() {
    prompt="$1"
    shift
    menu_opts=("$@") # global array
    case $menu_command in
    "wofi") wofi_menu ;;
    "rofi") rofi_menu ;;
    "walker") walker_menu ;;
    esac
}

wofi_menu() {
    printf '%s\n' "${menu_opts[@]}" | wofi --dmenu --prompt "$prompt" -m
}

rofi_menu() {
    printf '%s\n' "${menu_opts[@]}" | rofi \
        -dmenu \
        -p "$prompt" \
        -markup-rows
}

walker_menu() {
    printf '%s\n' "${menu_opts[@]}" | walker -p "$prompt" -d
}

define_menu
# Choose options
main_choice=$(show_menu "Select" "${main_opts[@]}") || exit 1

case "$main_choice" in
"󰹑 Capture") mode="normal" ;;
"󰁫 Timer capture") mode="timer" ;;
*) exit 1 ;;
esac

type_choice=$(show_menu "Type Of Screenshot" "${screenshot_opts[@]}") || exit 1
case "$type_choice" in
"󰍺 All Screen") option_type="screen" ;;
"󰍹 Active Screen") option_type="active" ;;
"󱣴 Capture Area") option_type="area" ;;
esac

if [[ $mode == "timer" ]]; then
    timer_choice=$(show_menu "Choose Timer" "${timer_opts[@]}") || exit 1
    countdown=${timer_choice%s} # remove 's'
fi

action_choice=$(show_menu "Action" "${action_opts[@]}") || exit 1
case "$action_choice" in
" Copy") option_action="copy" ;;
" Save") option_action="save" ;;
" Copy &amp; Save") option_action="copysave" ;;
" Edit") option_action="edit" ;;
esac

# Timer function
timer() {
    for ((i = countdown; i > 0; i--)); do
        #First time and 10 last seconds
        if ((i <= 10 || i == countdown)); then
            notify-send -t 1000 "Taking Screenshot in $i"
        fi
        sleep 1
    done
}

# Take screenshot
takescreenshot() {
    grimblast --notify "$option_action" "$option_type"
}

[[ $mode == "timer" ]] && timer
takescreenshot
