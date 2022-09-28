{
  lib,
  stdenvNoCC,
  coreutils,
  scdoc,
  makeWrapper,
  wl-clipboard,
  libnotify,
  slurp,
  grim,
  jq,
  bash,
  hyprland ? null,
}:
stdenvNoCC.mkDerivation {
  pname = "grimblast";
  version = "0.1";
  src = ./.;

  buildInputs = [bash scdoc];
  makeFlags = ["PREFIX=$(out)"];
  nativeBuildInputs = [makeWrapper];

  postInstall = ''
    wrapProgram $out/bin/grimblast --prefix PATH ':' \
      "${lib.makeBinPath ([
        wl-clipboard
        coreutils
        libnotify
        slurp
        grim
        jq
      ]
      ++ lib.optional (hyprland != null) hyprland)}"
  '';

  meta = with lib; {
    description = "A helper for screenshots within hyprland, based on grimshot";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [misterio77];
  };
}
