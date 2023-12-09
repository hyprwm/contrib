# try_swap_workspace

Inspired from
[this discussion on the hyprland repository](https://github.com/hyprwm/Hyprland/discussions/835)
try_swap_workspace is a binding to mimic the 'arbitrary workspace on arbitrary
monitor' behavior known from may window managers. This means:

- if a workspace is not displayed on any monitor and should be displayed, it
  gets displayed on the currently focused monitor
- if a workspace is already displayed on another monitor and should displayed on
  the currently focused monitor, the displayed workspace on the focused monitor
  will be swapped with the workspace on the monitor that should be displayed on
  the focused monitor
