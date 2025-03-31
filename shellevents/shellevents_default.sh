#!/bin/sh

# default handlers for shellevents
#
# override the function in your own events
# file to provide a custom handler
#
# comments inside each handler list the variables
# that are set when the handler is invoked

event_workspace() {
  : # WORKSPACENAME
}

event_workspacev2() {
  : # WORKSPACEID WORKSPACENAME
}

event_focusedmon() {
  : # MONNAME WORKSPACENAME
}

event_activewindow() {
  : # WINDOWCLASS WINDOWTITLE
}

event_activewindowv2() {
  : # WINDOWADDRESS
}

event_fullscreen() {
  : # ENTER (0 if leaving fullscreen, 1 if entering)
}

event_monitorremoved() {
  : # MONITORNAME
}

event_monitoradded() {
  : # MONITORNAME
}

event_monitoraddedv2() {
  : # MONITORID MONITORNAME MONITORDESCRIPTION
}

event_createworkspace() {
  : # WORKSPACENAME
}

event_createworkspacev2() {
  : # WORKSPACEID WORKSPACENAME
}

event_destroyworkspace() {
  : # WORKSPACENAME
}

event_destroyworkspacev2() {
  : # WORKSPACEID WORKSPACENAME
}

event_moveworkspace() {
  : # WORKSPACENAME MONNAME
}

event_moveworkspacev2() {
  : # WORKSPACEID WORKSPACENAME MONNAME
}

event_renameworkspace() {
  : # WORKSPACEID NEWNAME
}

event_activespecial() {
  : # WORKSPACENAME MONNAME
}

event_activelayout() {
  : # KEYBOARDNAME LAYOUTNAME
}

event_openwindow() {
  : # WINDOWADDRESS WORKSPACENAME WINDOWCLASS WINDOWTITLE
}

event_closewindow() {
  : # WINDOWADDRESS
}

event_movewindow() {
  : # WINDOWADDRESS WORKSPACENAME
}

event_movewindowv2() {
  : # WINDOWADDRESS WORKSPACEID WORKSPACENAME
}

event_windowtitle() {
  : # WINDOWADDRESS
}

event_windowtitlev2() {
  : # WINDOWADDRESS WINDOWTITLE
}

event_openlayer() {
  : # NAMESPACE
}

event_closelayer() {
  : # NAMESPACE
}

event_submap() {
  : # SUBMAPNAME
}

event_changefloatingmode() {
  : # WINDOWADDRESS FLOATING
}

event_urgent() {
  : # WINDOWADDRESS
}

event_minimized() {
  : # WINDOWADDRESS MINIMIZED
}

event_screencast() {
  : # STATE OWNER
}

event_togglegroup() {
  : # STATE WINDOWADDRESSSES
}

event_moveintogroup() {
  : # WINDOWADDRESS
}

event_moveoutofgroup() {
  : # WINDOWADDRESS
}

event_ignoregrouplock() {
  : # STATE
}

event_lockgroups() {
  : # STATE
}

event_configreloaded() {
  :
}

event_pin() {
  : # WINDOWADDRESS PINSTATE
}
