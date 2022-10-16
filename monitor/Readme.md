# Monitor Script

This Script will help the user to Cycle in monitors using one shortcut.

e.g

```
bind=SUPER,SPACE,exec,~/binaries/hypr/mon-focus
bind=SUPERSHIFT,SPACE,exec,~/binaries/hypr/win-mon
```

## Note

These scripts are interdependent.
Make sure they all lie in the same dir and call directly not by any symlinks.

## Requirements

- python3
- Hyprland (duh..)
- hyprctl (Should be there if u got Hyprland normally not from any wizard.)

## USE

> next-mon : This script will just give the output of the next monitor in the cycle in stdout.

> win-mon : This will use next-mon script to get next monitor name and will move the currently focused window to next monitor.

> mon-focus : This will also use next-mon script but this will get your focus to the next monitor.

One key to cycle all Monitors.
