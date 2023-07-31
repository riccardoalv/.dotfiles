{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };
  outputs = attrs@{ nixpkgs, nixpkgs-unstable, home-manager, nixos-hardware
    , ... }:
    let
      username = "ricardo";
      system = "x86_64-linux";

      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };
      defaultModules = [
        /etc/nixos/hardware-configuration.nix
        ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable ]; })
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.users.${username} = import ./home;
        }
      ];
    in {
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = attrs;
          modules = [ ./system/laptop-configuration.nix ] ++ defaultModules;
        };

        desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = attrs;
          modules = [ ./system/desktop-configuration.nix ] ++ defaultModules;
        };
      };
    };
}
