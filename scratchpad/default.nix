{
  lib,
  stdenvNoCC,
  makeWrapper,
  libnotify,
  gawk,
  gnused,
  jq,
  procps,
  bash,
  hyprland ? null,
}:
stdenvNoCC.mkDerivation {
  pname = "scratchpad";
  version = "0.1";
  src = ./.;

  buildInputs = [bash];
  makeFlags = ["PREFIX=$(out)"];
  nativeBuildInputs = [makeWrapper];

  postInstall = ''
    wrapProgram $out/bin/scratchpad --prefix PATH ':' \
      "${lib.makeBinPath ([
        gawk
        gnused
        jq
        libnotify
        procps
      ]
      ++ lib.optional (hyprland != null) hyprland)}"
  '';

  meta = with lib; {
    description = "A helper for scratchpads within Hyprland";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [fufexan];
    mainProgram = "scratchpad";
  };
}
