{
  lib,
  stdenvNoCC,
  makeWrapper,
  scdoc,
  coreutils,
  util-linux,
  jq,
  libnotify,
  withHyprland ? true,
  hyprland,
  gawk,
}:
stdenvNoCC.mkDerivation {
  pname = "hdrop";
  version = "0.5.0";

  src = ./.;

  nativeBuildInputs = [
    makeWrapper
    scdoc
  ];

  makeFlags = ["PREFIX=$(out)"];

  postInstall = ''
    wrapProgram $out/bin/hdrop --prefix PATH ':' \
      "${lib.makeBinPath ([
        coreutils
        util-linux
        jq
        libnotify
        gawk
      ]
      ++ lib.optional withHyprland hyprland)}"
  '';

  meta = with lib; {
    description = "Emulate 'tdrop' in Hyprland (run, show and hide specific programs per keybind)";
    homepage = "https://github.com/Schweber/hdrop";
    changelog = "https://github.com/Schweber/hdrop/releases/tag/v${version}";
    license = licenses.agpl3;
    platforms = platforms.linux;
    maintainers = with maintainers; [Schweber];
    mainProgram = "hdrop";
  };
}
