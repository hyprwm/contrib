#!/usr/bin/env bash

# Nikhil Singh <nik.singh710@gmail.com>

# Variables
_action=send
_listing=false
_menu_cmd="rofi -dmenu -i -p scratchpad"
green="\033[0;32m"
red="\033[0;31m"
blue="\033[0;34m"
nocolor="\033[0m"
default_scratchpad_name="${HYPRLAND_SCRATCHPAD_NAME:-scratchpad}"

check() {
  command -v "$1" 1>/dev/null
}

ok() {
  echo -e "[$green  $nocolor] $*"
}

err() {
  echo -e "[$red  $nocolor] $*"
}

optional() {
  echo -e "[$blue  $nocolor] $*"
}

notify() {
  # shellcheck disable=SC2015
  check notify-send && {
    notify-send "$@"
  } || {
    echo "$@"
  }
}

checkUtils() {
  # shellcheck disable=SC2015
  check sed && ok "sed" || err "sed"
  # shellcheck disable=SC2015
  check jq && ok "jq" || err "jq"
  # shellcheck disable=SC2015
  check notify-send && ok "notify-send (Optional)" || optional "notify-send (Optional)"
  exit
}

basicChecks() {
  check hyprctl || {
    notify "Seriously mate!!" "Start Hyprland before this script"
    exit 1
  }
  pgrep Hyprland &>/dev/null || {
    notify "Make Sure Hyprland Session is running."
    exit 1
  }
}

help() {
  cat <<EOF
  This is a bash script for quick movement of windows to Scratchpad for Hyprland using hyprctl.

  Invoking the command without flag will move the focused window to scratchpad.

  flags:
    -h: Displays This help menu
    -c: Checks for all dependencies
    -n: Sets the name of scratchpad workspace. default is scratchpad (can be set using env var HYPRLAND_SCRATCHPAD_NAME)
        Usefull if you want to have multiple scratchpads.
    -g: To bring back client from scratchpad to current workspace.
        if only one client is present then no menu is popped and client will me moved.
        if want menu before moving even if count of client is one then use in combination with -l.
    -l: Forces to display list even if only one window is on scratchpad.
        (Usefull if u don't remember which single window is at scratchpad)
    -t: Takes you to the scratchpad
    -m: Sets the menu program. e.g 'scratchpad -m "rofi -dmenu -i"'
                                   'scratchpad -m "bemenu"'
        This program will be used to display list of clients present on scratchpad with there address.
        default is (${_menu_cmd[@]})

  Usage:
    bind = SUPER, s, exec, /path/to/scratchpad/binary
    bind = SUPERSHIFT, s, exec, /path/to/scratchpad/binary -g

    bind = SUPERSHIFT, s, exec, /path/to/scratchpad/binary -l -g 
    (This will give client title and make sure that choice is asked to the user)
EOF
}

takes() {
  hyprctl dispatch workspace "special:$default_scratchpad_name"
  exit 0
}

getBack() {
  _ifs="$IFS"
  IFS=$'\n'$'\n'

  if pgrep "${_menu_cmd%% *}" >/dev/null; then killall -q "${_menu_cmd%% *}"; fi # Menu running already? → exit

  _current_workspace="$(hyprctl monitors -j | jq '.[] | select(.focused==true)' | jq -j '.activeWorkspace.name')"

  [ -z "$_current_workspace" ] && {
    notify "Scratchpad" "Some Error Occured while getting current workspace."
    exit 1
  }

  readarray -t _clients_on_spad < <(hyprctl clients -j |
    jq '.[] | select(.workspace.name=="special:'"$default_scratchpad_name"'")' |
    jq -j '[.class, .title, .address] | @text' |
    sed -z -e 's/]/]\n/g' \
      -e 's/["]//g' \
      -e 's/,/ /g' \
      -e 's/\[//g' \
      -e 's/]//g')

  [ "${#_clients_on_spad[@]}" -eq 0 ] && {
    notify "No Clients" "There was no client on $default_scratchpad_name"
    exit 0
  }
  [ "${#_clients_on_spad[@]}" -eq 1 ] && {
    $_listing || {
      _selected_client="${_clients_on_spad[0]}"
    }
  }
  [ -z "$_selected_client" ] && _selected_client="$(echo "${_clients_on_spad[*]}" | eval "${_menu_cmd[*]}")"
  _address="$(echo "$_selected_client" | awk '{print $NF}')"
  hyprctl dispatch movetoworkspace "$_current_workspace,address:$_address"
  hyprctl dispatch focuswindow "address:$_address"
  [ "$(hyprctl activewindow -j | jq '.floating')" = true ] && {
    hyprctl dispatch bringactivetotop none
  }
  IFS="$_ifs"
}

send() {
  hyprctl dispatch movetoworkspacesilent "special:$default_scratchpad_name"
}

getArgs() {
  while [ "$#" -gt 0 ]; do
    case "$1" in
    -h | --help)
      help
      exit 0
      ;;
    -g)
      _action="getBack"
      ;;
    -l)
      _listing=true
      ;;
    -t)
      _action="takes"
      ;;
    -m)
      _menu_cmd=("$2")
      shift
      ;;
    -c)
      _action="checkUtils"
      ;;
    -n)
      default_scratchpad_name="$2"
      shift
      ;;
    *)
      help
      echo ""
      echo "Wrong argument given"
      exit 1
      ;;
    esac
    shift
  done
}

basicChecks
getArgs "$@"
"$_action"
