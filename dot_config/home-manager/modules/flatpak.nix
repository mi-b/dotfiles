{ ... }:

{
  services.flatpak = {
    enable = true;
    packages = [
      # GPU-dependent apps remain on Flatpak until nixGL is verified
      "org.mozilla.firefox"
      "org.videolan.VLC"
    ];
  };
}
