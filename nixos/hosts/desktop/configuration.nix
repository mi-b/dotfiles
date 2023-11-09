# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, pkgs-unstable, ... }:
let
  modules = "../../modules";
  packages = import ./${modules}/packages.nix { inherit config pkgs pkgs-unstable; };
in
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./boot.nix
      ./hardware.nix

      # Include all other specifications.
      ./${modules}/windowing.nix
      ./${modules}/display.nix
      ./${modules}/keyboard.nix
      ./${modules}/fonts.nix
      ./${modules}/time.nix
      ./${modules}/environment.nix
      ./${modules}/networking.nix
      ./${modules}/security.nix

      ./${modules}/services.nix

      ./${modules}/sound.nix
      ./${modules}/printing.nix

      ./${modules}/virtualization.nix
      packages
      ./${modules}/programs.nix

      ./${modules}/user.nix

      ./${modules}/nix.nix
    ];

  ### NixOS Release Settings===================================================
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  system.stateVersion = "23.05";
  # ===========================================================================
}
