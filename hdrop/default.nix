{
  lib,
  stdenvNoCC,
  makeWrapper,
  coreutils,
  util-linux,
  jq,
  libnotify,
  hyprland ? null,
}:
stdenvNoCC.mkDerivation {
  pname = "hdrop";
  version = "0.1";

  src = ./.;

  nativeBuildInputs = [
    makeWrapper
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
    license = licenses.agpl;
    platforms = platforms.unix;
    # maintainers = with maintainers; [];
    mainProgram = "hdrop";
  };
}
