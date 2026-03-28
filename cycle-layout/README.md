# cycle-layout

Tiny script to cycle layouts (dwindle, scrolling, monocle, master) for current workspace.

## Usage

Run Makefile or simply copy this script where you'd want to, then add this to your hyprland config: 

```ini
# Set next layout
bind = SUPER CTRL, tab, exec, cycle-layout
# Set previous layout
bind = SUPER SHIFT CTRL, tab, exec, cycle-layout --prev
```

