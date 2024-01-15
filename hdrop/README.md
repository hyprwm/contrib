# hdrop

This Bash script emulates the main features of [tdrop](https://github.com/noctuid/tdrop) in Hyprland:

- if the specified program is not running: launch it and bring it to the foreground.
- if the specified program is already running on another workspace: bring it to the current workspace and focus it.
- if the specified program is already on the current workspace: move it to workspace 'special:hdrop', thereby hiding it until called up again by hdrop.

#### Usage:

> hdrop [OPTIONS] [COMMAND]

#### Arguments:

> [COMMAND]  
> The usual command you would run to start the desired program

#### Options:

> -b, --background  
> Changes the default behaviour: if the specified program is not running, launch it in the background instead of in the foreground. Thereafter `hdrop -b` will work the same as without this flag.
>
> -c, --class  
> Set classname of the program to be run. Use this if the classname is different from the name of the [COMMAND] and hdrop does not have a hardcoded replacement.
>
> -i, --insensitive  
> Case insensitive partial matching of class names. Can work as a stopgap if a running program is not recognized and a new instance is launched instead. Note: incorrect matches may occur, adding a special handling of the program to hdrop (hardcoded or via `-c, --class`) is preferable.
>
> -v, --verbose  
> Show notifications regarding the matching process. Try this to figure out why running programs are not matched.
>
> -h, --help  
> Print help message
>
> -V, --version  
> Print version

#### Multiple instances:

Multiple instances of the same program can be run concurrently, if different class names are assigned to each instance. Presently, there is support for the following flags in the [COMMAND] string:

> `-a` ([foot](https://codeberg.org/dnkl/foot/) terminal emulator)  
> `--class` (all other programs)

#### Example bindings in Hyprland config:

> bind = $mainMod, b, exec, hdrop librewolf  
> bind = $mainMod, x, exec, hdrop kitty --class kitty_1  
> bind = $mainMod CTRL, x, exec, hdrop kitty --class kitty_2  
> bind = $mainMod, c, exec, hdrop foot -a foot_1  
> bind = $mainMod CTRL, c, exec, hdrop foot -a foot_2

Note: defining a class name is only necessary when running several instances of the same program.

If you want to run a program on boot and have it wait in the background until called up by hdrop you can use this:

> exec-once = hdrop -b librewolf

## Troubleshooting

If hdrop can't match an already running program and starts a new instance instead, then its class name is most likely different from its command name. For example, the class name of `telegram-desktop` is `org.telegram.desktop` and the class name of `logseq` is `Logseq`.

Run `hdrop -v [COMMAND]` _in the terminal_ to see maximum output for troubleshooting and find out the actual class name. Then use `hdrop -c CLASSNAME` to make it work. `hdrop -i [COMMAND]` might be sufficient, as long as a case insensitive (partial) match is sufficient.

Please report instances of programs with differing class names, so that they can be added to `hdrop`.

## Installation

### Repositories

[![Packaging status](https://repology.org/badge/vertical-allrepos/hdrop.svg)](https://repology.org/project/hdrop/versions)

### Manual

Make sure that `bash` and `jq` are in your PATH.

Download the script, make it executable and add it to your PATH.

Note: `hdrop` will only work in a `Hyprland` session.

### Makefile

Use the provided Makefile.

## See also

`hdrop` is part of [hyprwm/contrib](https://github.com/hyprwm/contrib), which is a collection of useful scripts for `Hyprland`.
