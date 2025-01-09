{
  description = "HP 240 G5 Notebook NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, nix-flatpak, nix-ld, ... }:
    let
      system = "x86_64-linux";
      refindCommit = "8f539dc72d1a1d56adb8d434b4ba85bd3e63cf6d";
    in
    {
      nixosConfigurations.goat = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          nix-flatpak.nixosModules.nix-flatpak
          nix-ld.nixosModules.nix-ld
          (builtins.fetchTarball { url = "https://gist.github.com/mbekkomo/ba3d86f021aec0f73ceec4047365ef5b/archive/${refindCommit}.tar.gz"; } + "/refind.nix")
          ./configuration.nix
        ];
      };
    };
}
