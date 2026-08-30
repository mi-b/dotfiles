{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # nixGL should not follow nixpkgs:
    # the nixGL's nvidia wrapper is incompatible with current nixpkgs-unstable
    # (kernel argument removed from nvidia-x11)
    nixgl.url = "github:nix-community/nixGL";

    catppuccin.url = "github:catppuccin/nix";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixgl,
      catppuccin,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      mkHomeConfiguration =
        host:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit nixgl;
          };
          modules = [
            catppuccin.homeModules.catppuccin
            ./hosts/${host}.nix
          ];
        };
    in
    {
      homeConfigurations.mib = mkHomeConfiguration "chuebel";
      homeConfigurations.herbert = mkHomeConfiguration "abakus";

      formatter.${system} = pkgs.nixfmt-tree;
    };
}
