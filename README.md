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
