{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = { url = "github:nix-community/home-manager/release-23.11"; };
    grub2-themes = {
      url = "github:vinceliuice/grub2-themes";
    };
  };
  outputs = { nixpkgs, home-manager, grub2-themes, ... }:
    let
      username = "ricardo";
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./system/laptop-configuration.nix
            /etc/nixos/hardware-configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.users.${username} = import ./home;
            }
            grub2-themes.nixosModules.default
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
            }
            grub2-themes.nixosModules.default

          ];
        };
      };
    };
}
