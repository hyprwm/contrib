grimblast(1)

# NAME

grimblast - a helper for screenshots within Hyprland

# SYNOPSIS

*grimblast* [OPTIONS] (copy|save|copysave|edit) [TARGET] [FILE]++
*grimblast* check++
*grimblast* usage

# OPTIONS

*-n, --notify*
	Show notifications to the user that a screenshot has been taken.

*-o, --openparentdir*
	Uses dbus to display the folder containing the file when interacting with the
	notification, only works with --notify

*-e, --expire-time <ms>*
	Passes this argument to `notify-send` to configure notification expiry.
	Only works with --notify. Default: 3000.

*-c, --cursor*
	Include cursors in the screenshot.

*-f, --freeze*
	Freezes the screen before area selection.

*-w N, --wait N*
	Wait for N seconds before taking a screenshot. Decimal values
	are also supported. Waits after any manual selection is made.
	Recommended to combine with --notify in order to know
	when the screenshot has been taken.

*-s N, --scale N*
	Passes the `-s` argument to `grim`.

*-t TYPE, --filetype TYPE*
	Output filetype. Supported: png, ppm, jpeg. Default: png. Note: copy and copysave actions only support PNG format.

*save*
	Save the screenshot into a regular file. Grimblast will write image
	files to *XDG_SCREENSHOTS_DIR* if this is set (or defined
	in *user-dirs.dir*), otherwise fall back to *XDG_PICTURES_DIR*,
	and finally *HOME* if neither is defined.
	Set FILE to '-' to pipe the output to STDOUT.

*copy*
	Copy the screenshot data into the clipboard. Only PNG format is supported for clipboard operations.

*copysave*
	Combine the previous 2 options. Only PNG format is supported for clipboard operations.

*edit*
	Open screenshot in the image editor of your choice. The default is
	gimp, but you can set a different one with the environment variable
	$GRIMBLAST_EDITOR. Example: `export GRIMBLAST_EDITOR=gimp`.

*check*
	Verify whether the required tools are installed.

*usage*
	Show help message.

# DESCRIPTION

Grimblast is an easy-to-use screenshot utility for Hyprland, based on grimshot.
It provides a convenient interface over grim, slurp and jq, and supports
storing the screenshot either directly to the clipboard using wl-copy or to a
file.

# TARGETS

grimblast can capture the following named targets:

_active_
	Captures the currently active window.

_screen_
	Captures the entire screen. This includes all visible outputs.

_area_
	Allows manually selecting a rectangular region or window (by clicking on it),
	and captures that.
	Slurp can be customized by setting its arguments in the *SLURP_ARGS*
	environment variable.

_output_
	Captures the currently active output.

# ENVIRONMENT VARIABLES

*DEFAULT_TARGET_DIR*
	Directory where screenshots are saved when using the _save_ action.
	Defaults to *XDG_SCREENSHOTS_DIR* if set, otherwise *XDG_PICTURES_DIR*,
	and finally *HOME* if neither is defined.

*DEFAULT_TMP_EDITOR_DIR*
	Temporary directory used when editing screenshots. Defaults to */tmp*.

*GRIMBLAST_EDITOR*
	Image editor to use with the _edit_ action. Defaults to *gimp*.

*DATE_FORMAT*
	Date format string used for screenshot filenames. Defaults to *%Y%m%d_%H%M%S*.

*SLURP_ARGS*
	Additional arguments to pass to *slurp* for customizing the selection interface.

# OUTPUT

Grimblast will print the filename of the captured screenshot to stdout if called
with the _save_ subcommand.

# EXAMPLES

An example usage pattern is to add these bindings to your hyprland config:

```
# Screenshots:
# Super+P: Current window
# Super+Shift+p: Select area
# Super+Alt+p Current output
# Super+Ctrl+p All outputs

# Optionally, customize slurp's appearance
env = SLURP_ARGS, -d -b -B F050F022 -b 10101022 -c ff00ff

bind = SUPER, p, exec, grimblast save active
bind = SUPER SHIFT, p, exec, grimblast save area
bind = SUPER ALT, p, exec, grimblast save output
bind = SUPER CTRL, p, exec, grimblast save screen
```

Using *satty* as the image editor:

```
GRIMBLAST_EDITOR="satty --filename" grimblast edit screen
```

Using combined short options with satty:

```
GRIMBLAST_EDITOR="satty --file" grimblast -ns 2 -e 2000 edit screen
```

This example captures the entire screen, scales the image by a factor of 2, displays a notification that expires after 2000ms, and opens the screenshot in satty for editing.

Copy screenshot to clipboard:

```
grimblast copy active
```

Save screenshot with custom filename:

```
grimblast save screen ~/screenshots/my-screenshot.png
```

Take screenshot after a 2-second delay:

```
grimblast --wait 2 save area
```

Take screenshot and both save and copy:

```
grimblast copysave screen
```

Save screenshot in JPEG format:

```
grimblast --filetype jpeg save screen
```

# EXIT CODES

0 - Normal exit++
2 - Another instance of grimblast is running

# SEE ALSO

*grim*(1)
*slurp*(1)
*grimshot*(1)
