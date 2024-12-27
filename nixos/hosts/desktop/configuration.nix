# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  inputs,
  outputs,
  settings,
  ...
}:
let
  pkgsStable = import inputs.nixpkgsStable {
    system = pkgs.system;
    config = {
      allowUnfree = true;
    };
  };
in
{
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-gpu-nvidia-nonprime
    inputs.hardware.nixosModules.common-pc-ssd

    # Load the NixOS age encryption module to encrypt/decrypt
    # secrets with this NixOS configuration
    # inputs.agenix.nixosModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
    ./boot.nix
    ./hardware.nix
    ./system.nix

    # Include all other specifications.
    (outputs.nixosModules.windowing { inherit config pkgs pkgsStable; })
    outputs.nixosModules.keyboard
    outputs.nixosModules.fonts
    outputs.nixosModules.time
    outputs.nixosModules.environment
    outputs.nixosModules.networking
    outputs.nixosModules.security

    outputs.nixosModules.services

    outputs.nixosModules.sound
    outputs.nixosModules.printing

    outputs.nixosModules.virtualization

    (outputs.nixosModules.packages {
      inherit
        config
        pkgs
        pkgsStable
        inputs
        ;
    })
    outputs.nixosModules.programs

    outputs.nixosModules.user

    outputs.nixosModules.nix

    # Load home-manager as a part of the NixOS configuration.
    inputs.home-manager.nixosModules.home-manager
    (outputs.nixosModules.home-manager {
      inherit
        config
        inputs
        outputs
        pkgsStable
        ;
    })
  ];

  nixpkgs = {
    # You can add overlays here.
    overlays = [
      # NOTE: We are not eagerly using overlays so far, we pass inputs directly to modules.
      #       Overlays is a recursive mechanism which is only used when a
      #       package needs to be overwrittern globally.

      # Add overlays of your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      # outputs.overlays.unstable-packages
    ];
  };
  # ===========================================================================
}
