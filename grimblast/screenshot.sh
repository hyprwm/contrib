#!/usr/bin/env bash

## Author  : Aditya Shakya (adi1090x)
## Github  : @adi1090x
#
## Applets : Screenshot (Ported to use Grimblast)

## Modify
## Author  : Gonçalo Duarte (MrDuartePT)
## Github  : @MrDuartePT

## Port for Grimblast (https://github.com/hyprwm/contrib/tree/main/grimblast)
## Aur Package: grimblast-git (https://aur.archlinux.org/packages/grimblast-git)

## Add this to the ~/.config/user-dirs.dirs to save in the Screenshots folder: XDG_SCREENSHOTS_DIR="$HOME/Screenshots"

prompt='Screenshot'
mesg="DIR: ~/Screenshots"

# Options
option_1="󰹑 Capture"
option_2="󰁫 Timer capture"

option_capture_1="󰍺 All Screen"
option_capture_2="󰍹 Capture Active Screen"
option_capture_3="󱣴 Capture Area/Window/Application"

option_time_1="5s"
option_time_2="10s"
option_time_3="20s"
option_time_4="30s"
option_time_5="60s"
#option_time_4="Custom (in seconds)" # Roadmap or someone contribute :)

list_col='1'
list_row='2'
win_width='300px'

copy=' Copy'
save=' Save'
copy_save='Copy & Save'
edit='Edit Screenshot'

# Rofi CMD
rofi_cmd() {
  rofi -theme-str "window {width: $win_width;}" \
    -theme-str "listview {columns: $list_col; lines: $list_row;}" \
    -theme-str 'textbox-prompt-colon {str: "";}' \
    -dmenu \
    -p "$prompt" \
    -mesg "$mesg" \
    -markup-rows
}

# Pass variables to rofi dmenu
run_rofi() {
  echo -e "$option_1\n$option_2" | rofi_cmd
}

####
# Choose Timer
# CMD
timer_cmd() {
  rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 400px;}' \
    -theme-str 'mainbox {orientation: vertical; children: [ "message", "listview" ];}' \
    -theme-str 'listview {columns: 1; lines: 5;}' \
    -theme-str 'element-text {horizontal-align: 0.5;}' \
    -theme-str 'textbox {horizontal-align: 0.5;}' \
    -dmenu \
    -p 'Choose Option' \
    -mesg 'Choose timer:'
}

# Ask for confirmation
timer_exit() {
  echo -e "$option_time_1\n$option_time_2\n$option_time_3\n$option_time_4\n$option_time_5" | timer_cmd
}

# Confirm and execute
timer_run() {
  selected_timer="$(timer_exit)"
  if [[ "$selected_timer" == "$option_time_1" ]]; then
    countdown=5
    ${1}
  elif [[ "$selected_timer" == "$option_time_2" ]]; then
    countdown=10
    ${1}
  elif [[ "$selected_timer" == "$option_time_3" ]]; then
    countdown=20
    ${1}
  elif [[ "$selected_timer" == "$option_time_4" ]]; then
    countdown=30
    ${1}
  elif [[ "$selected_timer" == "$option_time_5" ]]; then
    countdown=60
    ${1}
  fi
}
###

####
# Chose Screenshot Type
# CMD
type_screenshot_cmd() {
  rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 400px;}' \
    -theme-str 'mainbox {orientation: vertical; children: [ "message", "listview" ];}' \
    -theme-str 'listview {columns: 1; lines: 3;}' \
    -theme-str 'element-text {horizontal-align: 0.5;}' \
    -theme-str 'textbox {horizontal-align: 0.5;}' \
    -dmenu \
    -p 'Choose Option' \
    -mesg 'Type Of Screenshot:'
}

# Ask for confirmation
type_screenshot_exit() {
  echo -e "$option_capture_1\n$option_capture_2\n$option_capture_3" | type_screenshot_cmd
}

# Confirm and execute
type_screenshot_run() {
  selected_type_screenshot="$(type_screenshot_exit)"
  if [[ "$selected_type_screenshot" == "$option_capture_1" ]]; then
    option_type_screenshot=screen
    ${1}
  elif [[ "$selected_type_screenshot" == "$option_capture_2" ]]; then
    option_type_screenshot=output
    ${1}
  elif [[ "$selected_type_screenshot" == "$option_capture_3" ]]; then
    option_type_screenshot=area
    ${1}
  fi
}
###

####
# Choose to save or copy photo
# CMD
copy_save_editor_cmd() {
  rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 400px;}' \
    -theme-str 'mainbox {orientation: vertical; children: [ "message", "listview" ];}' \
    -theme-str 'listview {columns: 2; lines: 2;}' \
    -theme-str 'element-text {horizontal-align: 0.5;}' \
    -theme-str 'textbox {horizontal-align: 0.5;}' \
    -dmenu \
    -p 'Choose Option' \
    -mesg 'Copy/save the screenshot or open in image editor'
}

# Ask for confirmation
copy_save_editor_exit() {
  echo -e "$copy\n$save\n$copy_save\n$edit" | copy_save_editor_cmd
}

# Confirm and execute
copy_save_editor_run() {
  selected_chosen="$(copy_save_editor_exit)"
  if [[ "$selected_chosen" == "$copy" ]]; then
    option_chosen=copy
    ${1}
  elif [[ "$selected_chosen" == "$save" ]]; then
    option_chosen=save
    ${1}
  elif [[ "$selected_chosen" == "$copy_save" ]]; then
    option_chosen=copysave
    ${1}
  elif [[ "$selected_chosen" == "$edit" ]]; then
    option_chosen=edit
    ${1}
  fi
}
###

timer() {
  if [[ $countdown -gt 10 ]]; then
    notify-send -t 1000 "Taking Screenshot in ${countdown} seconds"
    countdown_less_10=$((countdown - 10))
    sleep $countdown_less_10
    countdown=10
  fi
  while [[ $countdown -ne 0 ]]; do
    notify-send -t 1000 "Taking Screenshot in ${countdown}"
    countdown=$((countdown - 1))
    sleep 1
  done
}

# take shots
takescreenshot() {
  grimblast --notify "$option_chosen" "$option_type_screenshot"
}

takescreenshot_timer() {
  timer
  grimblast --notify "$option_chosen" "$option_type_screenshot"
}

# Execute Command
run_cmd() {
  if [[ "$1" == '--opt1' ]]; then
    type_screenshot_run
    copy_save_editor_run "takescreenshot"
  elif [[ "$1" == '--opt2' ]]; then
    timer_run
    type_screenshot_run
    copy_save_editor_run "takescreenshot_timer"
  fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
$option_1)
  run_cmd --opt1
  ;;
$option_2)
  run_cmd --opt2
  ;;
esac
