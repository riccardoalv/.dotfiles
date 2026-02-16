{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      lanzaboote,
      ...
    }:
    let
      system = "x86_64-linux";
      username = "ricardo";

      commonModule =
        { ... }:
        {
          nixpkgs = {
            config.allowUnfree = true;
          };
        };

      homeModule = {
        home-manager.useGlobalPkgs = true;
        home-manager.users.${username} = import ./home;
      };
    in
    {
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            commonModule
            ./system/hosts/laptop
            lanzaboote.nixosModules.lanzaboote
            home-manager.nixosModules.home-manager
            homeModule
          ];
        };

        desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            commonModule
            ./system/hosts/desktop
            lanzaboote.nixosModules.lanzaboote
            home-manager.nixosModules.home-manager
            homeModule
          ];
        };
      };
    };
}
