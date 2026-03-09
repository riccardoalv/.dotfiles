{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    pkgsStable.url = "github:nixos/nixpkgs/nixos-24.11";

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
      pkgsStable,
      home-manager,
      lanzaboote,
      ...
    }:
    let
      system = "x86_64-linux";
      username = "ricardo";

      stable = import pkgsStable {
        inherit system;
        config.allowUnfree = true;
      };

      commonModule =
        { ... }:
        {
          nixpkgs.config.allowUnfree = true;
        };

      homeModule = {
        home-manager.useGlobalPkgs = true;
        home-manager.extraSpecialArgs = { inherit stable; };
        home-manager.users.${username} = import ./home;
      };
    in
    {
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit stable; };
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
          specialArgs = { inherit stable; };
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
