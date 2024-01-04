{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };
  outputs =
    attrs@{ nixpkgs, nixpkgs-unstable, home-manager, nixos-hardware, ... }:
    let
      username = "ricardo";
      system = "x86_64-linux";

      overlay = final: prev: {
        unstable = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      };

      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };
      defaultModules = [
        /etc/nixos/hardware-configuration.nix
        ({ config, pkgs, ... }: {
          nixpkgs.overlays = [ overlay-unstable overlay ];
        })
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
          modules = [
          ./system/laptop-configuration.nix
          nixos-hardware.nixosModules.common-cpu-amd
          nixos-hardware.nixosModules.common-cpu-amd-pstate
          nixos-hardware.nixosModules.common-gpu-amd
          nixos-hardware.nixosModules.nixos-hardware.nixosModules.common-pc-laptop
          nixos-hardware.nixosModules.common-pc-laptop-acpi_call
          nixos-hardware.nixosModules.common-pc-laptop-ssd
          ] ++ defaultModules;
        };

        desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = attrs;
          modules = [ ./system/desktop-configuration.nix ] ++ defaultModules;
        };
      };
    };
}
