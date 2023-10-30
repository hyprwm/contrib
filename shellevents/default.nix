{
  lib,
  stdenvNoCC,
  makeWrapper,
  coreutils,
  bash,
  hyprland ? null,
}:
stdenvNoCC.mkDerivation {
  pname = "shellevents";
  version = "0.1";
  src = ./.;

  buildInputs = [bash];
  makeFlags = ["PREFIX=$(out)"];
  nativeBuildInputs = [makeWrapper];

  postInstall = ''
    wrapProgram $out/bin/shellevents --prefix PATH ':' \
      "${lib.makeBinPath ([coreutils]
        ++ lib.optional (hyprland != null) hyprland)}"
  '';

  meta = with lib; {
    description = "Run shell scripts in response to Hyprland events";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [fufexan];
    mainProgram = "shellevents";
  };
}
