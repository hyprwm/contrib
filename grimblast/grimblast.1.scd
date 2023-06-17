grimblast(1)

# NAME

grimblast - a helper for screenshots within hyprland

# SYNOPSIS

*grimblast* [--notify] [--cursor] [--freeze] [--scale <scale>] (copy|save|copysave|edit) [TARGET] [FILE]++
*grimblast* check++
*grimblast* usage

# OPTIONS

*--notify*
	Show notifications to the user that a screenshot has been taken.

*--cursor*
	Include cursors in the screenshot.

*--freeze*
	Freezes the screen before area selection.

*--scale <scale>*
	Passes the `-s` argument to `grim`.

*save*
	Save the screenshot into a regular file. Grimblast will write image
	files to *XDG_SCREENSHOTS_DIR* if this is set (or defined
	in *user-dirs.dir*), or otherwise fall back to *XDG_PICTURES_DIR*.
	Set FILE to '-' to pipe the output to STDOUT.

*copy*
	Copy the screenshot data (as image/png) into the clipboard.

*copysave* 
	Combine the previous 2 options.

*edit*
	Open screenshot in the image editor of your choice. The default is
	gimp, but you can set a different one with the enviroment variable
	$GRIMBLAST_EDITOR. Example: `export GRIMBLAST_EDITOR=gimp`.

*check*
	Verify whether the required tools are installed.

*usage*
	Show help message.

# DESCRIPTION

Grimblast is an easy-to-use screenshot utility for hyprland, based on grimshot.
It provides a convenient interface over grim, slurp and jq, and supports
storing the screenshot either directly to the clipboard using wl-copy or to a
file.

# EXAMPLES

An example usage pattern is to add these bindings to your hyprland config:

```
# Screenshots:
# Super+P: Current window
# Super+Shift+p: Select area
# Super+Alt+p Current output
# Super+Ctrl+p All outputs

bind = SUPER, p, exec, grimblast save active
bind = SUPER SHIFT, p, exec, grimblast save area
bind = SUPER ALT, p, exec, grimblast save output
bind = SUPER CTRL, p, exec, grimblast save screen
```

# TARGETS

grimblast can capture the following named targets:

_active_
	Captures the currently active window.

_screen_
	Captures the entire screen. This includes all visible outputs.

_area_
	Allows manually selecting a rectangular region or window (by clicking on it),
	and captures that.

_output_
	Captures the currently active output.

# OUTPUT

Grimblast will print the filename of the captured screenshot to stdout if called
with the _save_ subcommand.

# SEE ALSO

*grim*(1)
*grimshot*(1)
