{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.host.signalDesktop.enable = lib.mkEnableOption "Signal Desktop";

  config = lib.mkIf config.host.signalDesktop.enable {
    home.packages = [
      (pkgs.symlinkJoin {
        name = "signal-desktop-wrapped";
        paths = [ pkgs.signal-desktop ];
        nativeBuildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          wrapProgram $out/bin/signal-desktop \
            --add-flags "--no-sandbox"
        '';
      })
    ];
  };
}
