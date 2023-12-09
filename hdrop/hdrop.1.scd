hdrop(1)

# NAME

hdrop - run, show and hide programs on Hyprland

# SYNOPSIS

*hdrop* [OPTIONS] [COMMAND]

# OPTIONS

*[COMMAND]* 
	The usual command you would run to start the desired program

*-b, --background*  
	changes the default behaviour: if the specified program is not running, launch it in the background instead of foreground. Thereafter 'hdrop -b' will work the same as without this flag.

*-h, --help*  
	Print help message

*-V, --version*  
	Print version

# Description

This script emulates the main features of [tdrop](https://github.com/noctuid/tdrop) in Hyprland:

- if the specified program is not running: launch it and bring it to the foreground.
- if the specified program is already running on another workspace: bring it to the current workspace and focus it.
- if the specified program is already on the current workspace: move it to workspace 'special:hdrop', thereby hiding it until called up again by hdrop.

# Multiple instances:

Multiple instances of the same program can be run concurrently, if different class names are assigned to each instance. Presently there is support for the following flags in the [COMMAND] string:

```
-a ('foot' terminal emulator)  
--class (all other programs).
```

# Example bindings in Hyprland config:

```
bind = $mainMod, b, exec, hdrop librewolf'  
bind = $mainMod, x, exec, hdrop kitty --class kitty_1'  
bind = $mainMod CTRL, x, exec, hdrop kitty --class kitty_2'  
bind = $mainMod, c, exec, hdrop foot -a foot_1'  
bind = $mainMod CTRL, c, exec, hdrop foot -a foot_2'
```

Note: defining a class name is only necessary when running several instances of the same program.

If you want to run a program on boot and have it wait in the background until called up by hdrop you can use this:

```
exec-once = hdrop -b librewolf
```

Please feel free to report missing flags or peculiarities for other programs!

Dependencies: bash jq hyprland  
Part of: https://github.com/hyprwm/contrib  
Author: Schweber (https://github.com/Schweber/hdrop)  
License: AGPL3
