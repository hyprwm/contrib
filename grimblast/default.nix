{
  lib,
  stdenvNoCC,
  makeWrapper,
  scdoc,
  coreutils,
  grim,
  jq,
  libnotify,
  slurp,
  wl-clipboard,
  hyprpicker,
  hyprland ? null,
}:
stdenvNoCC.mkDerivation {
  pname = "grimblast";
  version = "0.1";

  src = ./.;

  nativeBuildInputs = [
    makeWrapper
  ];

  buildInputs = [
    scdoc
  ];

  makeFlags = ["PREFIX=$(out)"];

  postInstall = ''
    wrapProgram $out/bin/grimblast --prefix PATH ':' \
      "${lib.makeBinPath ([
        coreutils
        grim
        jq
        libnotify
        slurp
        wl-clipboard
        hyprpicker
      ]
      ++ lib.optional (hyprland != null) hyprland)}"
  '';

  meta = with lib; {
    description = "A helper for screenshots within Hyprland, based on grimshot";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [misterio77];
    mainProgram = "grimblast";
  };
}
