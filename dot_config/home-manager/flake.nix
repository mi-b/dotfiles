{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.7.0";

    nixgl = {
      url = "github:nix-community/nixGL";
      # Do not follow nixpkgs — nixGL's nvidia wrapper is incompatible with
      # current nixpkgs-unstable (kernel argument removed from nvidia-x11).
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      catppuccin,
      nix-flatpak,
      nixgl,
      ...
    }:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      pkgsFor = system: nixpkgs.legacyPackages.${system};

      mkHomeConfiguration =
        host:
        home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor "x86_64-linux";
          extraSpecialArgs = {
            inherit nixgl;
          };
          modules = [
            catppuccin.homeModules.catppuccin
            nix-flatpak.homeManagerModules.nix-flatpak
            ./hosts/${host}.nix
          ];
        };
    in
    {
      homeConfigurations.mib = mkHomeConfiguration "chuebel";
      homeConfigurations.herbert = mkHomeConfiguration "abakus";

      formatter = forAllSystems (system: (pkgsFor system).nixfmt-tree);

      checks = forAllSystems (
        system:
        let
          pkgs = pkgsFor system;
        in
        {
          formatting = pkgs.runCommandLocal "check-formatting" { } ''
            cd ${./.}
            ${pkgs.nixfmt-tree}/bin/treefmt --no-cache --fail-on-change --tree-root . . > $out 2>&1 || {
              echo "Formatting check failed. Run 'nix fmt' to fix."
              exit 1
            }
          '';
        }
      );
    };
}
