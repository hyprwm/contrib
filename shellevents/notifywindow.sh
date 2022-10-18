# shellcheck shell=sh

# send a notification whenever
# a window with the title Reddit
# is opened

event_openwindow() {
  case "$WINDOWTITLE" in
  [rR]eddit*)
    notify-send --icon=Reddit \
      'Reddit window opened' \
      "title: $WINDOWTITLE\nworkspace: $WORKSPACENAME\naddress:$WINDOWADDRESS\nclass:$WINDOWCLASS"
    ;;
  esac
}
