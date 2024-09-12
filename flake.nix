{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = { url = "github:nix-community/home-manager/release-24.05"; };
    grub2-themes = {
      url = "github:vinceliuice/grub2-themes";
    };
  };
  outputs = { nixpkgs, nixpkgs-unstable, home-manager, grub2-themes, auto-cpufreq, ... }:
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
    in
    {
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./system/laptop-configuration.nix
            /etc/nixos/hardware-configuration.nix
            auto-cpufreq.nixosModules.default
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.users.${username} = import ./home;
              home-manager.extraSpecialArgs = { inherit unstable; };
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
              home-manager.extraSpecialArgs = { inherit unstable; };
            }
            grub2-themes.nixosModules.default

          ];
        };
      };
    };
}
