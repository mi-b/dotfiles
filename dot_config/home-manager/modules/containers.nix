{ pkgs, ... }:

{
  xdg.configFile."containers/containers.conf".text = ''
    [engine]
    helper_binaries_dir = ["${pkgs.podman}/libexec/podman", "/usr/bin", "/usr/sbin"]
  '';
}
