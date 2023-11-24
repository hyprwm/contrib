{
  description = "Hypr Development Contrib";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    genSystems = nixpkgs.lib.genAttrs [
      "x86_64-linux"
      "aarch64-linux"
    ];
    pkgsFor = nixpkgs.legacyPackages;
  in {
    overlays.default = _: prev: {
      grimblast = prev.callPackage ./grimblast {hyprland = null;};
      hdrop = prev.callPackage ./hdrop {hyprland = null;};
      hyprprop = prev.callPackage ./hyprprop {};
      scratchpad = prev.callPackage ./scratchpad {hyprland = null;};
      shellevents = prev.callPackage ./shellevents {hyprland = null;};
      try_swap_workspace = prev.callPackage ./try_swap_workspace {};
    };

    packages = genSystems (system: self.overlays.default null pkgsFor.${system});

    formatter = genSystems (system: pkgsFor.${system}.alejandra);
  };
}
