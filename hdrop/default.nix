{
  lib,
  stdenvNoCC,
  makeWrapper,
  scdoc,
  coreutils,
  util-linux,
  jq,
  libnotify,
  hyprland ? null,
}:
stdenvNoCC.mkDerivation {
  pname = "hdrop";
  version = "0.2.4";

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
      ]
      ++ lib.optional (hyprland != null) hyprland)}"
  '';

  meta = with lib; {
    description = "Emulate 'tdrop' in Hyprland (show and hide specific programs per keybind)";
    license = licenses.agpl3;
    platforms = platforms.unix;
    # maintainers = with maintainers; [];
    mainProgram = "hdrop";
  };
}
