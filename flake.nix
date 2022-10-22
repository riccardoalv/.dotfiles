{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    grub2-themes = {
      url = "github:vinceliuice/grub2-themes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs:
    let
      username = "ricardo";
      system = "x86_64-linux";
    in {
      nixosConfigurations = {
        laptop = inputs.nixpkgs.lib.nixosSystem {
          system = system;
          specialArgs = { inherit inputs; };
          modules = builtins.attrValues {
            hardware-configuration =
              import /etc/nixos/hardware-configuration.nix;
            system-configuration = import ./system/laptop-configuration.nix;
          };
        };
        desktop = inputs.nixpkgs.lib.nixosSystem {
          system = system;
          specialArgs = { inherit inputs; };
          modules = builtins.attrValues {
            hardware-configuration =
              import /etc/nixos/hardware-configuration.nix;
            system-configuration = import ./system/desktop-configuration.nix;
          };
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
