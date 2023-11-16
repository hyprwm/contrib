# Hypr Development Contrib

Community scripts and utilities for Hypr projects

# Tools

## Grimblast

A Hyprland version of Grimshot.

Install by running the Makefile or just copying the `grimblast` script in your `~/.bin`.

## shellevents

Invoke shell functions in response to Hyprland socket2 events. Install with `make install`.

See `shellevents_default.sh` for the supported function names. Example event files can be found in `submaps.sh` and `notifywindow.sh`.

## try_swap_workspace

Inspired from [this discussion on the hyprland repository](https://github.com/hyprwm/Hyprland/discussions/835) try_swap_workspace is a binding to mimic the 'arbitrary workspace on arbitrary monitor' on arbitrary monitor behavior known from may window managers.
This means:
- if a workspace is not displayed on any monitor and should be displayed, it gets displayed on the currently focused monitor
- if a workspace is already displayed on another monitor and should displayed on the currently focused monitor, the displayed workspace on the focused monitor will be swapped with the workspace on the monitor that should be displayed on the focused monitor

Install by running the Makefile `sudo make install`
Uninstall by running the Makefile `sudo make uninstall`

Usage:

To send the window to scratchpad
> bind= ALT,1,exec, try_swap_workspace 1

use `-h` flag to get help.
use `-c` flag to check dependencies

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

## hdrop

This script emulates the main features of [tdrop](https://github.com/noctuid/tdrop) in Hyprland:

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
> changes the default behaviour: if the specified program is not running, launch it in the background instead of foreground. Thereafter 'hdrop -b' will work the same as without this flag.
>
> -h, --help  
> Print this help message
>
> -V, --version  
> Print version

#### Multiple instances:

Multiple instances of the same program can be run concurrently, if different class names are assigned to each instance. Presently there is support for the following flags in the [COMMAND] string:

> -a ('foot' terminal emulator)  
> --class (all other programs).

#### Example bindings in Hyprland config:

> bind = $mainMod, b, exec, hdrop librewolf'  
> bind = $mainMod, x, exec, hdrop kitty --class kitty_1'  
> bind = $mainMod CTRL, x, exec, hdrop kitty --class kitty_2'  
> bind = $mainMod, c, exec, hdrop foot -a foot_1'  
> bind = $mainMod CTRL, c, exec, hdrop foot -a foot_2'

Note: defining a class name is only necessary when running several instances of the same program.

If you want to run a program on boot and have it wait in the background until called up by hdrop you can use this:

> exec-once = hdrop -b librewolf

Please feel free to report missing flags or peculiarities for other programs!

Dependencies: bash jq hyprland  
Author: Schweber (https://github.com/Schweber/hdrop)  
License: AGPL3


# Installing

## Manual

Clone the repo, cd to your desired tool, run `make` to build. To install, run
`make install`. You may need root privileges.

## Nix

In your configuration flake, add
```nix
{
  inputs.hyprland-contrib = {
    url = "github:hyprwm/contrib";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  # ...
}
```

To make `inputs` available in your configurations, add this
```nix
# for Home Manager
homeConfigurations.YOURCONFIG = inputs.home-manager.lib.homeManagerConfiguration {
  pkgs = ...;
  modules = ...;

  extraSpecialArgs = {inherit inputs;};
}

# for NixOS
nixosConfigurations.YOURHOSTNAME = inputs.nixpkgs.nixosSystem {
  system = "...";
  modules = ...;

  specialArgs = {inherit inputs;};
}
```

For the final step, add packages to your `environment.systemPackages` or
`home.packages` in this format:
```nix
{pkgs, inputs, ...}: {
  environment.systemPackages = [ # or home.packages
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast # or any other package
  ];
}
```

# Contributing

Contributions are welcome! Please open a PR with your utility and describe how
it helps the Hypr ecosystem. Also provide a screen recording if possible,
demonstrating its usage.
While developing bash scripts, it is recommended to use `shellcheck` for
idiomatic ways to write them.
If your utility is written in bash, please add it to the
[checks matrix](https://github.com/hyprwm/contrib/blob/main/.github/workflows/check.yml).
