{ ... }:

{
  services.flatpak = {
    enable = true;
    packages = [
      "org.mozilla.firefox"
      "org.videolan.VLC"
      "org.gimp.GIMP"
      "org.inkscape.Inkscape"
    ];
  };
}
