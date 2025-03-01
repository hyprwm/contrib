# hdrop

This Bash script emulates the main features of [tdrop](https://github.com/noctuid/tdrop) in [Hyprland](https://github.com/hyprwm/Hyprland):

- if the specified program is not running: launch it and bring it to the foreground.
- if the specified program is already running on another workspace: bring it to the current workspace and focus it.
- if the specified program is already on the current workspace: move it to workspace 'special:hdrop', thereby hiding it until called up again by hdrop.

> \[!NOTE]
> I'm no longer using hyprland myself so i rely on user reports to repair breakage introduced by new hyprland versions.

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
> -f, --floating  
> Spawn as a floating window. Standard is top half, full width, no gap. Can be adjusted with -g, -h, -p and -w.
>
> -F, --focus  
> Changes the default behaviour: focus the specified program's window and switch to its present workspace if necessary. Do not hide it, if it's already on the current workspace."
>
> -g, --gap  
> If using --floating: specify gap to the screen edge in pixels.
>
> -h, --height  
> If using --floating: set the height of the window. Enter percentage value without % sign, e.g. '30'.
>
> -H, --help  
> Print help message
>
> -i, --insensitive  
> Case insensitive partial matching of class names. Can work as a stopgap if a running program is not recognized and a new instance is launched instead. Note: incorrect matches may occur, adding a special handling of the program to hdrop (hardcoded or via `-c, --class`) is preferable.
>
> -o, --online  
> Delay initial launch for up to 20 seconds until internet connectivity is established.
>
> -p, --position  
> If using --floating: set the position of the window. One of: '[t]op' '[b]ottom' '[l]eft' '[r]ight'.
>
> -v, --verbose  
> Show notifications regarding the matching process. Try this to figure out why running programs are not matched.
>
> -V, --version  
> Print version
>
> -w, --width  
> If using --floating: set the width of the window. Enter percentage value without % sign, e.g. '30'.

#### Multiple instances:

Multiple instances of the same program can be run concurrently, if different class names are assigned to each instance. Presently, there is support for the following flags in the [COMMAND] string:

> `-a` | `--app-id` ([foot](https://codeberg.org/dnkl/foot/) terminal emulator)  
> `--class` (all other programs)

#### Example bindings in Hyprland config:

> bind = $mainMod, b, exec, hdrop librewolf  
> bind = $mainMod, x, exec, hdrop kitty --class kitty_1  
> bind = $mainMod CTRL, x, exec, hdrop kitty --class kitty_2  
> bind = $mainMod, c, exec, hdrop foot -a foot_1  
> bind = $mainMod CTRL, c, exec, hdrop foot -a foot_2

> \[!NOTE]
> Defining a class name is only necessary when running several instances of the same program.

If you want to run a program on boot and have it wait in the background until called up by hdrop you can use this:

> exec-once = hdrop -b librewolf

## Troubleshooting

### Cursor jumps to newly focused windows

Set `no_warps = true` in `hyprland.conf` section [cursor](https://wiki.hyprland.org/Configuring/Variables/#cursor).

### Further instances of programs are started instead of hiding/unhiding a running instance

If hdrop can't match an already running program and starts a new instance instead, then its class name is most likely different from its command name. For example, the class name of `telegram-desktop` is `org.telegram.desktop` and the class name of `logseq` is `Logseq`.

Run `hdrop -v [COMMAND]` _in the terminal_ to see maximum output for troubleshooting and find out the actual class name. Then use `hdrop -c CLASSNAME` to make it work. `hdrop -i [COMMAND]` might be sufficient, as long as a case insensitive (partial) match is sufficient.

Please report instances of programs with differing class names, so that they can be added to `hdrop`.

### Windows freeze when being called up from another workspace

This happens sometimes and will apparently be fixed in hyprland 0.43

### `--floating` windows don't react to changed position arguments in hdrop

Close the program (don't just hide it with hdrop). The changed arguments are only applied when the program is restarted.

### `--floating` windows animation is only shown when the window is opened for the first time

This is a known issue and no workaround is known to me.

### `hdrop -b` is not working when used for autostart

If hdrop isn't installed but just added to PATH, then you might have to use this instead:

> exec-once = [workspace special:hdrop silent] hdrop [OPTIONS] [COMMAND]

## Installation

### Repositories

[![Packaging status](https://repology.org/badge/vertical-allrepos/hdrop.svg)](https://repology.org/project/hdrop/versions)

### Manual

Make sure that `bash`, `jq` and `awk` (for using the `--floating` option) are in your PATH.

Download the script, make it executable and add it to your PATH.

Note: `hdrop` will only work in a `Hyprland` session.  
`exec-once = hdrop -b` might not work with this installation method.

### Makefile

Use the provided Makefile.

## See also

`hdrop` is part of [hyprwm/contrib](https://github.com/hyprwm/contrib), which is a collection of useful scripts for `Hyprland`.

[ndrop](https://github.com/schweber/ndrop) is the equivalent for [niri](https://github.com/YaLTeR/niri).

