{
  lib,
  stdenvNoCC,
  coreutils,
  scdoc,
  makeShellWrapper,
  libnotify,
  bash,
}:
stdenvNoCC.mkDerivation {
  pname = "try_swap_workspace";
  version = "0.1";
  src = ./.;

  buildInputs = [bash scdoc];
  makeFlags = ["DESTDIR=$(out)", "PREFIX=/usr"];
  nativeBuildInputs = [makeShellWrapper];

  postInstall = ''
    wrapProgramShell $out/bin/try_swap_workspace --prefix PATH ':' \
      "${lib.makeBinPath [
      coreutils
      libnotify
    ]}"
  '';

  meta = with lib; {
    description = "Workspace switching helper for Hyprland";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [fufexan];
  };
}
