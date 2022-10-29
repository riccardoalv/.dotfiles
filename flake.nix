{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    grub2-themes = {
      url = "github:vinceliuice/grub2-themes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = attrs@{ nixpkgs, home-manager, nixos-hardware, grub2-themes, ... }:
    let
      username = "ricardo";
      system = "x86_64-linux";
    in {
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = attrs;
          modules = [
            ./system/laptop-configuration.nix
            /etc/nixos/hardware-configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.users.${username} = import ./home;
            }
          ];
        };
        desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = attrs;
          modules = [
            ./system/desktop-configuration.nix
            /etc/nixos/hardware-configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.users.${username} = import ./home;
            }
          ];
        };
      };
    };
}
