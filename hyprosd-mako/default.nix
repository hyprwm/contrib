{
  lib,
  stdenvNoCC,
  makeWrapper,
  brightnessctl,
  coreutils,
  libnotify,
  mako,
  wireplumber,
}:
stdenvNoCC.mkDerivation {
  pname = "hyprosd-mako";
  version = "0.1";

  src = ./.;

  nativeBuildInputs = [
    makeWrapper
  ];

  makeFlags = [ "PREFIX=$(out)" ];

  postInstall = ''
    for i in {volume,brightness,mic}; do
      wrapProgram "$out/bin/$i-notify" --prefix PATH ':' \
        "${
          lib.makeBinPath ([
            coreutils
            mako
            wireplumber
            brightnessctl
            libnotify
          ])
        }"
    done
  '';

  meta = with lib; {
    description = "Lightweight OSD notifications for Hyprland using Mako";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [ ];
    mainProgram = "volume-notify";
  };
}
