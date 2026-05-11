# cycle-layout

Tiny script to cycle layouts (dwindle, scrolling, monocle, master) for current workspace.

## Usage

Run Makefile or simply copy this script where you'd want to, then add this to your hyprland config: 

```lua
hl.bind("SUPER + CTRL + tab",         hl.dsp.exec_cmd("cycle-layout")) -- Set next layout
hl.bind("SUPER + SHIFT + CTRL + tab", hl.dsp.exec_cmd("cycle-layout --prev")) -- Set previous layout
```

