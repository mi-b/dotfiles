{ pkgs, ... }:

{
  services.flatpak = {
    enable = true;
    # Note: proprietary apps with apply_extra scripts (Chrome, VS Code) fail
    # in nix-flatpak's sandboxed install. Install those manually or via .deb.
    packages = [
      "org.mozilla.firefox"
      "org.videolan.VLC"
      "org.gimp.GIMP"
      "org.inkscape.Inkscape"
    ];
  };
}
