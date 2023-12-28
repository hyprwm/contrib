# Hypr Development Contrib

Community scripts and utilities for Hypr projects

# Tools

| Name                                       | Description                                                                                                                                                          | Maintainer(s)         |
| ------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------- |
| [grimblast](./grimblast)                   | A Hyprland version of Grimshot                                                                                                                                       | @fufexan, @Misterio77 |
| [shellevents](./shellevents)               | Invoke shell functions in response to Hyprland socket2 events                                                                                                        | @trippwill            |
| [try_swap_workspace](./try_swap_workspace) | Binding to mimic the 'arbitrary workspace on arbitrary monitor' behavior                                                                                             | @schievel1            |
| [scratchpad](./scratchpad)                 | A Bash script that instantly sends focused window to a special workspace named `scratchpad` and makes it easier to retrieve the window back to the current workspace | @niksingh710          |
| [hdrop](./hdrop)                           | Run, show and hide programs via keybind. Emulates [tdrop](https://github.com/noctuid/tdrop) in Hyprland                                                              | @Schweber             |

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
demonstrating its usage. While developing bash scripts, it is recommended to use
`shellcheck` for idiomatic ways to write them. If your utility is written in
bash, please add it to the
[checks matrix](https://github.com/hyprwm/contrib/blob/main/.github/workflows/check.yml).
