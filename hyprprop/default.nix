{
  lib,
  stdenvNoCC,
  coreutils,
  scdoc,
  makeWrapper,
  slurp,
  jq,
  bash,
}:
stdenvNoCC.mkDerivation {
  pname = "hyprprop";
  version = "0.1";
  src = ./.;

  buildInputs = [bash scdoc];
  makeFlags = ["PREFIX=$(out)"];
  nativeBuildInputs = [makeWrapper];

  postInstall = ''
    wrapProgram $out/bin/hyprprop --prefix PATH ':' \
      "${lib.makeBinPath [
      coreutils
      slurp
      jq
    ]}"
  '';

  meta = with lib; {
    description = "An xprop replacement for Hyprland";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [fufexan];
  };
}
