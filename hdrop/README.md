# hdrop

This script emulates the main features of
[tdrop](https://github.com/noctuid/tdrop) in Hyprland:

- if the specified program is not running: launch it and bring it to the
  foreground.
- if the specified program is already running on another workspace: bring it to
  the current workspace and focus it.
- if the specified program is already on the current workspace: move it to
  workspace 'special:hdrop', thereby hiding it until called up again by hdrop.

#### Usage:

```console
hdrop [OPTIONS] [COMMAND]
```

#### Arguments:

> `[COMMAND]`\
> The usual command you would run to start the desired program

#### Options:

> `-b, --background`\
> changes the default behaviour: if the specified program is not running, launch
> it in the background instead of foreground. Thereafter 'hdrop -b' will work
> the same as without this flag.
>
> `-h, --help`\
> Print this help message
>
> `-V, --version`\
> Print version

See man page for further information.
