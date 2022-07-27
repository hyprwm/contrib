{
  description = "Hypr Development Contrib";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    genSystems = nixpkgs.lib.genAttrs [
      "x86_64-linux"
    ];
    pkgsFor = nixpkgs.legacyPackages;
  in {
    overlays.default = _: prev: {
      grimblast = prev.callPackage ./grimblast {hyprland = null;};
    };

    packages = genSystems (system: self.overlays.default null pkgsFor.${system});

    formatter = genSystems (system: pkgsFor.${system}.alejandra);
  };
}
