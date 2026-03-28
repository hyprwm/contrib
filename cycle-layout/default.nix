{
  hyprland,
  lib,
  makeWrapper,
  stdenvNoCC,
  withHyprland ? true,
}:
stdenvNoCC.mkDerivation {
  pname = "cycle-layout";
  version = "0.1.0";

  src = ./.;

  nativeBuildInputs = [
    makeWrapper
  ];

  makeFlags = [ "PREFIX=$(out)" ];

  postInstall = lib.optionalString withHyprland ''
    wrapProgram $out/bin/cycle-layout --prefix PATH ':' "${lib.makeBinPath [hyprland]}"
  '';

  meta = with lib; {
    description = "Script to cycle layouts for the current workspace in Hyprland";
    license = licenses.mit;
    platforms = platforms.linux;
    mainProgram = "cycle-layout";
  };
}
