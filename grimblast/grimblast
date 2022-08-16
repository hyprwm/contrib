#!/bin/sh
## Grimblast: a helper for screenshots within hyprland
## Requirements:
##  - `grim`: screenshot utility for wayland
##  - `slurp`: to select an area
##  - `hyprctl`: to read properties of current window
##  - `wl-copy`: clipboard utility
##  - `jq`: json utility to parse hyprctl output
##  - `notify-send`: to show notifications
## Those are needed to be installed, if unsure, run `grimblast check`
##
## See `man 1 grimblast` or `grimblast usage` for further details.

## Author: Misterio (https://github.com/misterio77)

## This tool is based on grimshot, with swaymsg commands replaced by their
## hyprctl equivalents.
## https://github.com/swaywm/sway/blob/master/contrib/grimshot

getTargetDirectory() {
  test -f "${XDG_CONFIG_HOME:-$HOME/.config}/user-dirs.dirs" && \
    . "${XDG_CONFIG_HOME:-$HOME/.config}/user-dirs.dirs"

  echo "${XDG_SCREENSHOTS_DIR:-${XDG_PICTURES_DIR:-$HOME}}"
}

NOTIFY=no
CURSOR=

while [ $# -gt 0 ]; do
  key="$1"

  case $key in
    -n|--notify)
      NOTIFY=yes
      shift # past argument
      ;;
    -c|--cursor)
      CURSOR=yes
      shift # past argument
      ;;
    *)    # unknown option
      break # done with parsing --flags
      ;;
  esac
done

ACTION=${1:-usage}
SUBJECT=${2:-screen}
FILE=${3:-$(getTargetDirectory)/$(date -Ins).png}

if [ "$ACTION" != "save" ] && [ "$ACTION" != "copy" ] && [ "$ACTION" != "check" ]; then
  echo "Usage:"
  echo "  grimblast [--notify] [--cursor] (copy|save) [active|screen|output|area|window] [FILE|-]"
  echo "  grimblast check"
  echo "  grimblast usage"
  echo ""
  echo "Commands:"
  echo "  copy: Copy the screenshot data into the clipboard."
  echo "  save: Save the screenshot to a regular file or '-' to pipe to STDOUT."
  echo "  check: Verify if required tools are installed and exit."
  echo "  usage: Show this message and exit."
  echo ""
  echo "Targets:"
  echo "  active: Currently active window."
  echo "  screen: All visible outputs."
  echo "  output: Currently active output."
  echo "  area: Manually select a region."
  echo "  window: Manually select a window."
  exit
fi

notify() {
  notify-send -t 3000 -a grimblast "$@"
}
notifyOk() {
  [ "$NOTIFY" = "no" ] && return

  TITLE=${2:-"Screenshot"}
  MESSAGE=${1:-"OK"}
  REST=${@: 3}
  notify "$TITLE" "$MESSAGE" $REST
}
notifyError() {
  if [ $NOTIFY = "yes" ]; then
    TITLE=${2:-"Screenshot"}
    MESSAGE=${1:-"Error taking screenshot with grim"}
    notify -u critical "$TITLE" "$MESSAGE"
  else
    echo "$1"
  fi
}

die() {
  MSG=${1:-Bye}
  notifyError "Error: $MSG"
  exit 2
}

check() {
  COMMAND=$1
  if command -v "$COMMAND" > /dev/null 2>&1; then
    RESULT="OK"
  else
    RESULT="NOT FOUND"
  fi
  echo "   $COMMAND: $RESULT"
}

takeScreenshot() {
  FILE=$1
  GEOM=$2
  OUTPUT=$3
  if [ -n "$OUTPUT" ]; then
    grim ${CURSOR:+-c} -o "$OUTPUT" "$FILE" || die "Unable to invoke grim"
  elif [ -z "$GEOM" ]; then
    grim ${CURSOR:+-c} "$FILE" || die "Unable to invoke grim"
  else
    grim ${CURSOR:+-c} -g "$GEOM" "$FILE" || die "Unable to invoke grim"
  fi
}

if [ "$ACTION" = "check" ] ; then
  echo "Checking if required tools are installed. If something is missing, install it to your system and make it available in PATH..."
  check grim
  check slurp
  check hyprctl
  check wl-copy
  check jq
  check notify-send
  exit
elif [ "$SUBJECT" = "area" ] ; then
  GEOM=$(slurp -d)
  # Check if user exited slurp without selecting the area
  if [ -z "$GEOM" ]; then
    exit 1
  fi
  WHAT="Area"
elif [ "$SUBJECT" = "active" ] ; then
  FOCUSED=$(hyprctl activewindow -j)
  GEOM=$(echo "$FOCUSED" | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')
  APP_ID=$(echo "$FOCUSED" | jq -r '.class')
  WHAT="$APP_ID window"
elif [ "$SUBJECT" = "screen" ] ; then
  GEOM=""
  WHAT="Screen"
elif [ "$SUBJECT" = "output" ] ; then
  GEOM=""
  OUTPUT=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true)' | jq -r '.name')
  WHAT="$OUTPUT"
elif [ "$SUBJECT" = "window" ] ; then
  MONITORS=$(hyprctl monitors -j)
  CLIENTS=$(hyprctl clients -j)
  SIZE=$(jq -r 'map(.width,.height)' <<< $MONITORS)
  WORKSPACES="$(jq -r 'map(.activeWorkspace.id)' <<< $MONITORS)"
  # Check if user is in fullscreen
  if [ -z "$(jq -r ".[] | select (.workspace.id == "$(echo $WORKSPACES | jq '.[]')" and .size == $SIZE)" <<< $CLIENTS)" ] ; then
    WINDOWS="$(jq -r --argjson workspaces "$WORKSPACES" 'map(select([.workspace.id] | inside($workspaces)))' <<< $CLIENTS )"
    GEOM=$(echo "$WINDOWS" | jq -r '.[] | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' | slurp -r)
    # Check if user exited slurp without selecting the area
    if [ -z "$GEOM" ]; then
      exit 1
    fi
    WHAT="Window"
  else
    GEOM=""
    WHAT="Screen"
  fi
else
  die "Unknown subject to take a screen shot from" "$SUBJECT"
fi

if [ "$ACTION" = "copy" ] ; then
  takeScreenshot - "$GEOM" "$OUTPUT" | wl-copy --type image/png || die "Clipboard error"
  notifyOk "$WHAT copied to buffer"
else
  if takeScreenshot "$FILE" "$GEOM" "$OUTPUT"; then
    TITLE="Screenshot of $SUBJECT"
    MESSAGE=$(basename "$FILE")
    notifyOk "$MESSAGE" "$TITLE" -i "$FILE"
    echo "$FILE"
  else
    notifyError "Error taking screenshot with grim"
  fi
fi
