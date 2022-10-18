# shellcheck shell=sh

# shellevents sample event file

# when entering the resize submap dim all inactive windows and
# add a very loud border to the active window

CURRENT_SUBMAP="${CURRENT_SUBMAP:=}"

resize_enter='keyword decoration:dim_inactive 1;keyword general:col.active_border 0xFFe7691e'
resize_exit='keyword decoration:dim_inactive 0;keyword general:col.active_border 0x8800ccde'

event_submap() {
  printf >&2 '%s\n' "$SUBMAPNAME"
  case "$SUBMAPNAME" in
  "resize")
    CURRENT_SUBMAP='resize'
    hyprctl --batch "$resize_enter"
    ;;
  *)
    case "$CURRENT_SUBMAP" in
    "resize")
      CURRENT_SUBMAP=''
      hyprctl --batch "$resize_exit"
      ;;
    esac
    ;;
  esac
}
