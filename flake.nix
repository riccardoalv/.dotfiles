{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };
  outputs = inputs:
    let
      username = "ricardo";
      system = "x86_64-linux";
    in {
      nixosModules = {
        hardware-configuration = import /etc/nixos/hardware-configuration.nix;
        system-configuration = import ./system/configuration.nix;
      };
      nixosConfigurations = {
        laptop = inputs.nixpkgs.lib.nixosSystem {
          system = system;
          specialArgs = { inherit inputs; };
          modules = builtins.attrValues inputs.self.nixosModules;
        };
      };

      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;

      homeConfigurations.${username} =
        inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = import inputs.nixpkgs {
            system = system;
            config.allowUnfree = true;
          };
          modules = [
            ./home
            {
              home.username = username;
              home.homeDirectory = "/home/${username}";
            }
          ];
        };
    };
}
