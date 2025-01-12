{
  description = "My Nix config :3";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nix-search-cli = {
      url = "github:peterldowns/nix-search-cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixGL = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    declarative-cachix.url = "github:jonascarpay/declarative-cachix";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
    nix-std.url = "github:chessai/nix-std";
    nix-ld = {
      url = "github:nix-community/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nix-search-cli,
      nixGL,
      declarative-cachix,
      nix-index-database,
      catppuccin,
      nix-std,
      nur,
      nix-flatpak,
      ...
    }:
    let
      system =
        let
          x = (builtins.getEnv "NIXPKGS_SYSTEM");
        in
        if x == "" then "x86_64-linux" else x;
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          nur.overlays.default
          (_: _: {
            nix-search = nix-search-cli.outputs.packages.${system}.nix-search;
            nixGLPackages = nixGL.outputs.packages.${system};
          })
        ];
      };
    in
    {
      homeConfigurations.komo = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          declarative-cachix.homeManagerModules.declarative-cachix
          nix-index-database.hmModules.nix-index
          catppuccin.homeManagerModules.catppuccin
          ./dotfiles/home.nix
        ];
        extraSpecialArgs.std = nix-std.lib;
      };

      nixosConfigurations.HP-240-G5-Notebook-PC = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          nix-flatpak.nixosModules.nix-flatpak
          ./modules/refind/refind.nix
          ./HP-240-G5-Notebook-PC/configuration.nix
        ];
      };

      nixosConfigurations.Aspire-TC-605 = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          nix-flatpak.nixosModules.nix-flatpak
          ./modules/refind/refind.nix
          ./Aspire-TC-605/configuration.nix
        ];
      };

      formatter.${system} = pkgs.nixfmt-rfc-style;
    };
}
