hdrop(1)

# NAME

hdrop - run, show and hide programs on Hyprland

# SYNOPSIS

*hdrop* [OPTIONS] [COMMAND]

# COMMAND 
	The usual command you would run to start the desired program

# OPTIONS

*-b, --background*  
	Changes the default behaviour: if the specified program is not running, launch it in the background instead of foreground. Thereafter 'hdrop -b' will work the same as without this flag.

*-c, --class*
	Set classname of the program to be run. Use this if the classname is different from the name of the [COMMAND] and hdrop has not yet a hardcoded replacement.

*-f, --floating*
	Spawn as a floating window. Standard is top half, full width, no gap. Can be adjusted with -g, -h, -p and -w.

*-g, --gap*
	If using --floating: specify gap to the screen edge in pixels.

*-h, --height*
	If using --floating: set the height of the window. Enter percentage value without % sign, e.g. '30'.

*-H, --help*  
	Print help message

*-i, --insensitive*
	Case insensitive partial matching of class names. Can work as a stopgap if a running program is not recognized and a new instance is launched instead. Note: incorrect matches may occur, adding a special handling of the program to *hdrop* (hardcoded or via *-c, --class*) is preferable.

*-p, --position*
	If using --floating: set the position of the window. One of: '[t]op' '[b]ottom' '[l]eft' '[r]ight'.

*-v, --verbose*  
	Show notifications regarding the matching process. Try this to figure out why running programs are not matched."

*-V, --version*  
	Print version

*-w, --width*
	If using --floating: set the width of the window. Enter percentage value without % sign, e.g. '30'.

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

# Troubleshooting

## Cursor jumps to newly focused windows

Set *no_cursor_warps = true* in *hyprland.conf* section general

## Further instances of programs are started instead of hiding/unhiding a running instance

If hdrop can't match an already running program and starts a new instance instead, then its class name is most likely different from its command name. For example, the class name of *telegram-desktop* is *org.telegram.desktop* and the class name of *logseq* is *Logseq*.

Run *hdrop -v [COMMAND]* _in the terminal_ to see maximum output for troubleshooting and find out the actual class name. Then use *hdrop -c CLASSNAME* to make it work. *hdrop -i [COMMAND]* might be sufficient, as long as a case insensitive (partial) match is sufficient.

Please report instances of programs with differing class names, so that they can be added to *hdrop*.

## Floating windows don't react to changed arguments

Close the program (don't just hide it with hdrop). The changed arguments are only applied when the program is restarted. 

# License 

Dependencies: bash jq hyprland  
Part of: https://github.com/hyprwm/contrib  
Author: Schweber (https://github.com/Schweber/hdrop)  
License: AGPL3
