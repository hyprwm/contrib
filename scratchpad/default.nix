{
  lib,
  stdenvNoCC,
  makeWrapper,
  libnotify,
  gnused,
  jq,
  bash,
  hyprland ? null,
}:
stdenvNoCC.mkDerivation {
  pname = "scratchpad";
  version = "0.1";
  src = ./.;

  buildInputs = [bash];
  makeFlags = ["DESTDIR=$(out)", "PREFIX=/usr"];
  nativeBuildInputs = [makeWrapper];

  postInstall = ''
    wrapProgram $out/bin/scratchpad --prefix PATH ':' \
      "${lib.makeBinPath ([
        gnused
        jq
        libnotify
      ]
      ++ lib.optional (hyprland != null) hyprland)}"
  '';

  meta = with lib; {
    description = "A helper for scratchpads within Hyprland";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [fufexan];
  };
}
