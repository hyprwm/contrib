# Hypr Development Contrib

Community scripts and utilities for Hypr projects

# Tools

## Grimblast

A Hyprland version of Grimshot.

Install by running the Makefile or just copying the `grimblast` script in your `~/.bin`.

## shellevents

Invoke shell functions in response to Hyprland socket2 events. Install with `make install`.

See `shellevents_default.sh` for the supported function names. Example event files can be found in `submaps.sh` and `notifywindow.sh`.

## Scratchpad
A Bash script that instantly sends focused window to a special workspace named `scratchpad`
and makes it easier to retrieve the window back to the current workspace.

Install by running the Makefile `sudo make install`
Uninstall by running the Makefile `sudo make uninstall`

Usage:

To send the window to scratchpad
> bind = SUPER, s, exec, scratchpad

To get back the window
>bind = SUPERSHIFT, s, exec, scratchpad -g

use `-h` flag to get help.


# Contributing

Contributions are welcome! Please open a PR with your utility and describe how
it helps the Hypr ecosystem. Also provide a screen recording if possible,
demonstrating its usage.
If your utility is written in bash, please add it to the
[checks](https://github.com/hyprwm/contrib/blob/main/.github/workflows/check.yml).

# Changelog

### 2022-02-26
Added the `edit` option to Grimblast. read the [man page](grimblast/grimblast.1.scd) for more information.

A rofi script is also included.

### 2022-02-27
Added Scratchpad Script.
