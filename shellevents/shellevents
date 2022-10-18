#!/bin/sh

## shellevents - run shell functions in response to Hyprland event
#
# shellevents reads Hyprland events from stdin as documented at: http://wiki.hyprland.org/IPC/#tmphyprhissocket2sock
#
# the event string is parsed, splitting the data into indivual arguments
# for each event recevied, a function with the name event_<eventname> is invoked
# when invoked, the data is passed as named arguments
#
# a seperate program is required to connect to Hyprland socket2 and pass the
# event strings to shellevents stdin. see usage below for an example using socat.
#
# Usage:
#
#   cp /path/to/shellevents_default.sh custom_event_file.sh
#
#   In custom_event_file.sh, add implementations for the events you want to handle.
#
#   socat -u UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock \
#     EXEC:"/path/to/shellevents /path/to/custom_event_file.sh",nofork
#
# Reload custom_event_file.sh:
#   killall shellevents -USR1
#
# Verbose
#   pass '-v' as first argument to shellevents to print all events to stderr

# load the default (empty) event implementations
# shellcheck disable=SC1091
. "$(dirname "$(readlink -mn "$0")")"/shellevents_default.sh

PFS=$IFS

load_events() {
  IFS=$PFS
  for f in $event_files; do
    # shellcheck disable=SC1090
    if . "$f"; then
      printf >&2 'loaded event file: %s\n' "$f"
    else
      printf >&2 'failed sourcing event file: %s\n' "$f"
      exit 2
    fi
  done
}

verbose=
case "$1" in
-v) verbose=1 && shift ;;
esac

event_files="$*"
load_events

trap 'load_events; continue' USR1

while true; do
  if read -r event_data; then
    event="${event_data%%>>*}"
    edata="${event_data#"$event">>}"

    IFS=','
    # shellcheck disable=SC2086 # splitting is intended
    set -- $edata
    IFS=$PFS

    if [ -n "$verbose" ]; then
      printf >&2 '[%s] 1:%s 2:%s 3:%s 4:%s\n' "$event" "$1" "$2" "$3" "$4"
    fi

    case "$event" in
    "workspace") WORKSPACENAME="$1" event_workspace ;;
    "focusedmon") MONNAME="$1" WORKSPACENAME="$2" event_focusedmon ;;
    "activewindow") WINDOWCLASS="$1" WINDOWTITLE="$2" event_activewindow ;;
    "fullscreen") ENTER="$1" event_fullscreen ;;
    "monitorremoved") MONITORNAME="$1" event_monitorremoved ;;
    "monitoradded") MONITORNAME="$1" event_monitoradded ;;
    "createworkspace") WORKSPACENAME="$1" event_createworkspace ;;
    "destroyworkspace") WORKSPACENAME="$1" event_destroyworkspace ;;
    "moveworkspace") WORKSPACENAME="$1" MONNAME="$2" event_moveworkspace ;;
    "activelayout") KEYBOARDNAME="$1" LAYOUTNAME="$2" event_activelayout ;;
    "openwindow") WINDOWADDRESS="$1" WORKSPACENAME="$2" WINDOWCLASS="$3" WINDOWTITLE="$4" event_openwindow ;;
    "closewindow") WINDOWADDRESS="$1" event_closewindow ;;
    "movewindow") WINDOWADDRESS="$1" WORKSPACENAME="$2" event_movewindow ;;
    "openlayer") NAMESPACE="$1" event_openlayer ;;
    "closelayer") NAMESPACE="$1" event_closelayer ;;
    "submap") SUBMAPNAME="$1" event_submap ;;
    *) printf >&2 'Unknown event: %s\n' "$event" ;;
    esac
  fi
done
