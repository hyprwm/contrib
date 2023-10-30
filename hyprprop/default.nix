{
  lib,
  stdenvNoCC,
  coreutils,
  scdoc,
  makeWrapper,
  slurp,
  makeDesktopItem,
  copyDesktopItems,
  jq,
  bash,
}:
let
  desktopItem = makeDesktopItem {
    name = "hyprprop";
    exec = "hyprprop";
    desktopName = "Hyprprop";
    terminal=true;
    startupNotify = false;
  };
in
stdenvNoCC.mkDerivation {
  pname = "hyprprop";
  version = "0.1";
  src = ./.;

  buildInputs = [bash scdoc];
  makeFlags = ["PREFIX=$(out)"];
  nativeBuildInputs = [makeWrapper copyDesktopItems];

  postInstall = ''
    wrapProgram $out/bin/hyprprop --prefix PATH ':' \
      "${lib.makeBinPath [
      coreutils
      slurp
      jq
    ]}"
  '';

  desktopItems = [ desktopItem ];

  meta = with lib; {
    description = "An xprop replacement for Hyprland";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [fufexan];
    mainProgram = "hyprprop";
  };
}
