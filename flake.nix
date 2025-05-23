{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = { url = "github:nix-community/home-manager/master"; };
  };
  outputs = { nixpkgs, nixpkgs-unstable, home-manager, lanzaboote, ... }:
    let
      username = "ricardo";
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.users.${username} = import ./home;
              home-manager.extraSpecialArgs = { inherit unstable; };
            }
            ./system/laptop-configuration.nix
            /etc/nixos/hardware-configuration.nix
            lanzaboote.nixosModules.lanzaboote
          ];
        };

        desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./system/desktop-configuration.nix

            /etc/nixos/hardware-configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.users.${username} = import ./home;
              home-manager.extraSpecialArgs = { inherit unstable; };
            }
            lanzaboote.nixosModules.lanzaboote
          ];
        };
      };
    };
}
